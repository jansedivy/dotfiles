def prompt_git_prompt_branch [] {
    let result = (do { git symbolic-ref --short HEAD } | complete)
    if $result.exit_code == 0 {
        $result.stdout | str trim
    } else {
        let hash = (do { git rev-parse --short HEAD } | complete)
        if $hash.exit_code == 0 {
            $hash.stdout | str trim
        } else {
            ""
        }
    }
}

def prompt_is_git_dirty [] {
    let result = (do { git status --porcelain } | complete)
    if $result.exit_code == 0 {
        ($result.stdout | str trim) != ""
    } else {
        false
    }
}

def prompt_need_push [] {
    let result = (do { git rev-parse --abbrev-ref '@{upstream}' } | complete)
    if $result.exit_code != 0 {
        return ""
    }

    let cherry = (do { git cherry -v '@{upstream}' } | complete)
    if $cherry.exit_code == 0 and ($cherry.stdout | str trim) != "" {
        $"(ansi blue)!(ansi reset)"
    } else {
        ""
    }
}

def prompt_git [] {
    let result = (do { git rev-parse --is-inside-work-tree } | complete)
    if $result.exit_code != 0 {
        return ""
    }

    let branch = (prompt_git_prompt_branch)
    if $branch == "" {
        return ""
    }

    let color = if (prompt_is_git_dirty) { ansi red } else { ansi green }
    let push = (prompt_need_push)
    $"\(($color)($branch)(ansi reset)($push)\)"
}

def prompt_jobs_count [] {
    let count = (job list | length)
    if $count > 0 {
        let marks = (1..$count | each { "!" } | str join)
        $"(ansi green)($marks)(ansi reset)"
    } else {
        ""
    }
}

def prompt_directory_name [] {
    $"(ansi blue)($env.PWD | path basename)(ansi reset)"
}

$env.PROMPT_COMMAND = {||
    $"(prompt_jobs_count)(prompt_directory_name)(prompt_git) › "
}

$env.PROMPT_COMMAND_RIGHT = ""
$env.PROMPT_INDICATOR = ""
