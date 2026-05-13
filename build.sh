#!/bin/bash
# snes9xgx Build Helper Script

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_header() {
    echo -e "${GREEN}=== $1 ===${NC}"
}

print_info() {
    echo -e "${YELLOW}➜${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

# Check environment
check_env() {
    print_header "Checking Environment"
    
    if [ -z "$DEVKITPRO" ]; then
        print_error "DEVKITPRO is not set"
        exit 1
    fi
    
    if [ -z "$DEVKITPPC" ]; then
        print_error "DEVKITPPC is not set"
        exit 1
    fi
    
    if [ -z "$PORTLIBS" ]; then
        print_error "PORTLIBS is not set"
        exit 1
    fi
    
    print_success "DEVKITPRO: $DEVKITPRO"
    print_success "DEVKITPPC: $DEVKITPPC"
    print_success "PORTLIBS: $PORTLIBS"
    
    if ! command -v powerpc-eabi-gcc &> /dev/null; then
        print_error "powerpc-eabi-gcc not found"
        exit 1
    fi
    
    print_success "powerpc-eabi-gcc found"
}

# Show usage
show_usage() {
    cat << EOF
Usage: $0 [OPTION]

Options:
    wii         Build for Nintendo Wii
    gc          Build for GameCube
    all         Build for both Wii and GameCube (default)
    clean       Clean all build artifacts
    help        Show this help message

Examples:
    $0 wii       # Build only Wii version
    $0 gc        # Build only GameCube version
    $0 all       # Build both (same as no arguments)
    $0 clean     # Clean build artifacts

EOF
}

# Main build function
build() {
    local target=$1
    
    check_env
    
    case $target in
        wii)
            print_header "Building for Nintendo Wii"
            make -f Makefile.wii
            print_success "Wii build complete!"
            print_info "Output: executables/snes9xgx-wii.dol"
            ;;
        gc)
            print_header "Building for GameCube"
            make -f Makefile.gc
            print_success "GameCube build complete!"
            print_info "Output: executables/snes9xgx-gc.dol"
            ;;
        all)
            print_header "Building for Nintendo Wii and GameCube"
            make -f Makefile.wii
            print_success "Wii build complete!"
            make -f Makefile.gc
            print_success "GameCube build complete!"
            print_info "Outputs:"
            print_info "  - executables/snes9xgx-wii.dol"
            print_info "  - executables/snes9xgx-gc.dol"
            ;;
        clean)
            print_header "Cleaning build artifacts"
            make -f Makefile.wii clean
            make -f Makefile.gc clean
            print_success "Clean complete!"
            ;;
        help|--help|-h)
            show_usage
            ;;
        *)
            print_error "Unknown target: $target"
            show_usage
            exit 1
            ;;
    esac
}

# Run main function
if [ $# -eq 0 ]; then
    build all
else
    build "$@"
fi
