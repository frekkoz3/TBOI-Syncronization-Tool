#!/bin/bash

# this is for Linux

# The path of your saving files
# usually is something like (Windows at least)
# "C:\Users\UserName\Documents\My Games\Binding of Isaac Repentance"
# Rememeber that this folder must contain a git repo in order to work
REPO_DIR="C:\Users\39346\Documents\My Games\Binding of Isaac Repentance"

# Default commit message
DEFAULT_MSG="quick save"

# Function to check repository
check_repo() {
    if [ ! -d "$REPO_DIR" ]; then
        echo "Error: Repository directory does not exist: $REPO_DIR"
        exit 1
    fi

    if ! git -C "$REPO_DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "Error: The specified directory is not a Git repository."
        exit 1
    fi
}

# Quick pull
quick_pull() {
    echo "Pulling latest changes..."
    git -C "$REPO_DIR" pull
}

# Quick local save (add + commit only)
quick_save() {
    MESSAGE=${1:-$DEFAULT_MSG}
    echo "Saving local changes..."
    git -C "$REPO_DIR" add --all
    git -C "$REPO_DIR" commit -m "$MESSAGE" || echo "No changes to commit."
}

# Quick local discard (reset + clean)
quick_discard() {
    echo "⚠️ Discarding all local changes..."
    read -p "Are you sure? This action cannot be undone! (y/N): " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        git -C "$REPO_DIR" reset --hard
        git -C "$REPO_DIR" clean -fd
        echo "All local changes discarded."
    else
        echo "Operation cancelled."
    fi
}

# Quick push (add + commit + push)
quick_push() {
    MESSAGE=${1:-"default"}
    echo "Pushing changes..."
    git -C "$REPO_DIR" add --all
    git -C "$REPO_DIR" commit -m "$MESSAGE" || echo "No changes to commit."
    git -C "$REPO_DIR" push
}

# Help message
show_help() {
    echo "Usage: gitquick <command> [commit message]"
    echo ""
    echo "Commands:"
    echo "  push [msg]     Add, commit, and push changes"
    echo "  pull           Pull latest changes"
    echo "  save [msg]     Add and commit locally"
    echo "  discard        Discard all local changes"
    echo "  help           Show this help message"
}

# Main logic
check_repo

case "$1" in
    push)
        shift
        quick_push "$*"
        ;;
    pull)
        quick_pull
        ;;
    save)
        shift
        quick_save "$*"
        ;;
    discard)
        quick_discard
        ;;
    help|--help|-h|"")
        show_help
        ;;
    *)
        echo "❌ Unknown command: $1"
        show_help
        exit 1
        ;;
esac
#!/bin/bash

# Fixed repository path
REPO_DIR="/path/to/your/repository"

# Default commit message
DEFAULT_MSG="quick save"

# Function to check repository
check_repo() {
    if [ ! -d "$REPO_DIR" ]; then
        echo "Error: Repository directory does not exist: $REPO_DIR"
        exit 1
    fi

    if ! git -C "$REPO_DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "Error: The specified directory is not a Git repository."
        exit 1
    fi
}

# Quick pull
quick_pull() {
    echo "Pulling latest changes..."
    git -C "$REPO_DIR" pull
}

# Quick local save (add + commit only)
quick_save() {
    MESSAGE=${1:-$DEFAULT_MSG}
    echo "Saving local changes..."
    git -C "$REPO_DIR" add --all
    git -C "$REPO_DIR" commit -m "$MESSAGE" || echo "No changes to commit."
}

# Quick local discard (reset + clean)
quick_discard() {
    echo "Discarding all local changes..."
    read -p "Are you sure? This action cannot be undone! (y/N): " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        git -C "$REPO_DIR" reset --hard
        git -C "$REPO_DIR" clean -fd
        echo "All local changes discarded."
    else
        echo "Operation cancelled."
    fi
}

# Quick push (add + commit + push)
quick_push() {
    MESSAGE=${1:-"default"}
    echo "Pushing changes..."
    git -C "$REPO_DIR" add --all
    git -C "$REPO_DIR" commit -m "$MESSAGE" || echo "No changes to commit."
    git -C "$REPO_DIR" push
}

# Help message
show_help() {
    echo "Usage: gitquick <command> [commit message]"
    echo ""
    echo "Commands:"
    echo "  push [msg]     Add, commit, and push changes"
    echo "  pull           Pull latest changes"
    echo "  save [msg]     Add and commit locally"
    echo "  discard        Discard all local changes"
    echo "  help           Show this help message"
}

# Main logic
check_repo

case "$1" in
    push)
        shift
        quick_push "$*"
        ;;
    pull)
        quick_pull
        ;;
    save)
        shift
        quick_save "$*"
        ;;
    discard)
        quick_discard
        ;;
    help|--help|-h|"")
        show_help
        ;;
    *)
        echo "❌ Unknown command: $1"
        show_help
        exit 1
        ;;
esac
