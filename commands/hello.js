
import { Command } from 'commander'
import chalk from 'chalk'

const command = new Command('hello')
    .description('Show a hello message')
    .action((options) => {
        const name = options.name || 'World'

        console.log(chalk.green(`Hello, ${name}!`))
    })

export default command
