import Project from '@core/entities/Project.ts'

export function useLogos(pr: Project) {
    return pr
        .mediaPoll('logos')
        .source('/home/rick/work/logos')
}
