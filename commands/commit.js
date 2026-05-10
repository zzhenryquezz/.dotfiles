import { Command } from 'commander'
import { execSync, spawnSync } from 'child_process'
import { select, confirm, editor } from '@inquirer/prompts'
import chalk from 'chalk'

function run(cmd) {
    try {
        return execSync(cmd, { encoding: 'utf8', stdio: ['pipe', 'pipe', 'pipe'] }).trim()
    } catch {
        return ''
    }
}

function parseOptions(response) {
    const options = []
    let current = null

    for (const line of response.split('\n')) {
        const trimmed = line.trim()

        if (trimmed.startsWith('Subject:')) {
            if (current) options.push(current)
            current = { subject: trimmed.replace(/^Subject:\s*/, ''), description: '' }
        } else if (trimmed.startsWith('Description:') && current) {
            current.description = trimmed.replace(/^Description:\s*/, '')
        }
    }

    if (current) options.push(current)

    return options
}

const command = new Command('commit')
    .description('Generate commit messages using GitHub Copilot')
    .action(async () => {
        try {
            execSync('git rev-parse --is-inside-work-tree', { stdio: 'pipe' })
        } catch {
            console.error('Error: not inside a git repository')
            process.exit(1)
        }

        const hasStagedChanges = !!run('git diff --cached --name-only')
        let diff = run('git diff --cached')
        if (!diff) diff = run('git diff')

        if (!diff) {
            console.log('No changes to commit')
            process.exit(0)
        }

        const truncatedDiff = diff.split('\n').slice(0, 400).join('\n')

        const prompt = [
            'You are a git commit message generator. Based on the following git diff, generate exactly 5 commit message options following conventional commits format (feat, fix, chore, docs, refactor, style, test, etc.).',
            '',
            'Output ONLY the options in this EXACT format — no numbering, no extra text before or after:',
            '',
            '---',
            'Subject: <type(scope): short subject, max 72 chars>',
            'Description: <what changed and why, 1-2 sentences>',
            '---',
            'Subject: <type(scope): short subject, max 72 chars>',
            'Description: <what changed and why, 1-2 sentences>',
            '',
            'Repeat for all 5 options.',
            '',
            'Git diff:',
            truncatedDiff,
        ].join('\n')

        console.log('⏳ Generating commit message options...')

        const result = spawnSync('copilot', ['--model', 'gpt-5-mini', '-p', prompt,], {
            encoding: 'utf8',
            stdio: ['pipe', 'pipe', 'pipe'],
        })

        const response = (result.stdout || '').trim()

        if (!response) {
            console.error('Error: no response from Copilot')
            if (result.stderr) console.error(result.stderr.trim())
            process.exit(1)
        }

        const options = parseOptions(response)

        if (options.length === 0) {
            console.error('Error: failed to parse options from response')
            console.error('\nRaw response:\n', response)
            process.exit(1)
        }

        console.log('\nSelect a commit message:\n')

        const selectedOption = await select({
            message: 'Select a commit message',
            choices: options.map((opt) => {
                // Highlight type(scope) in cyan, rest of subject in bold white
                const subject = opt.subject.replace(
                    /^([a-z]+(?:\([^)]+\))?)(:.+)/,
                    (_, tag, rest) => chalk.cyan(tag) + chalk.bold.white(rest)
                )

                return {
                    name: subject + '\n  ' + chalk.dim(opt.description),
                    value: options.indexOf(opt),
                    short: opt.subject,
                }
            }),
        })

        const selected = options[selectedOption]

        console.log(
            '\n' +
            chalk.green('✔') + ' ' + chalk.bold.white(selected.subject) + '\n' +
            '  ' + chalk.dim(selected.description) + '\n'
        )

        const wantsEdit = await confirm({ message: 'Edit the message before committing?', default: false })

        let finalSubject = selected.subject
        let finalDesc = selected.description

        if (wantsEdit) {
            const commitMessage = await editor({
                message: 'Edit commit message',
                default: `${selected.subject}\n\n${selected.description}\n`,
                waitForUseInput: false,
            })

            const lines = commitMessage.split('\n')
            finalSubject = lines[0].trim()
            finalDesc = lines.slice(2).join('\n').trim()
        }

        if (!finalSubject) {
            console.error('Commit message is empty, aborting')
            process.exit(1)
        }

        if (!hasStagedChanges) {
            console.log('No staged changes detected. Staging all changes (git add -A)...')
            execSync('git add -A', { stdio: 'inherit' })
        }

        const commitArgs = ['-m', finalSubject]
        if (finalDesc) commitArgs.push('-m', finalDesc)

        spawnSync('git', ['commit', ...commitArgs], { stdio: 'inherit' })

        console.log('\n✅ Committed successfully!')
    })

export default command
