import { Command } from 'commander'
import { execSync } from 'child_process'
import chalk from 'chalk'

const command = new Command('aws-billing')
    .description('Show current month AWS billing cost')
    .option('-p, --profile <profile>', 'AWS profile to use')
    .action((options) => {
        const now = new Date()
        const start = new Date(now.getFullYear(), now.getMonth(), 1)
            .toISOString()
            .split('T')[0]

        const end = now.toISOString().split('T')[0]

        const profileFlag = options.profile ? `--profile ${options.profile}` : ''

        let raw
        try {
            raw = execSync(
                `aws ${profileFlag} ce get-cost-and-usage \
                    --time-period Start=${start},End=${end} \
                    --granularity MONTHLY \
                    --metrics "BlendedCost" "UnblendedCost" \
                    --group-by Type=DIMENSION,Key=SERVICE \
                    --output json`,
                { encoding: 'utf8', stdio: ['pipe', 'pipe', 'pipe'] }
            )
        } catch (err) {
            console.error(chalk.red('Error calling AWS Cost Explorer:'))
            console.error(err.stderr?.trim() || err.message)
            process.exit(1)
        }

        const data = JSON.parse(raw)
        const result = data.ResultsByTime?.[0]

        if (!result) {
            console.log('No billing data found for the current month.')
            return
        }

        const groups = (result.Groups || [])
            .map((g) => ({
                service: g.Keys[0],
                amount: parseFloat(g.Metrics.BlendedCost.Amount),
                currency: g.Metrics.BlendedCost.Unit,
            }))
            .filter((g) => g.amount > 0)
            .sort((a, b) => b.amount - a.amount)

        const currency = groups[0]?.currency || 'USD'
        const totalAmount = groups.reduce((sum, g) => sum + g.amount, 0)

        const label = now.toLocaleString('default', { month: 'long', year: 'numeric' })
        console.log(`\n${chalk.bold(`AWS Billing — ${label}`)}`)
        console.log(chalk.dim(`  ${start} → ${end}\n`))

        if (groups.length > 0) {
            const maxLen = Math.max(...groups.map((g) => g.service.length))
            for (const { service, amount } of groups) {
                const bar = '█'.repeat(totalAmount > 0 ? Math.round((amount / totalAmount) * 20) : 0)
                console.log(
                    `  ${chalk.cyan(service.padEnd(maxLen))}  ${chalk.yellow(bar.padEnd(20))}  ${chalk.white(amount.toFixed(2))} ${currency}`
                )
            }
            console.log()
        }

        console.log(`  ${chalk.bold('Total:')} ${chalk.green(totalAmount.toFixed(2))} ${currency}\n`)
    })

export default command
