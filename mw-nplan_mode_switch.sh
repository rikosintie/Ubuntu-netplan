# Function to switch netplan br0 from dhcp to static and vice versa
function mw-nplan_mode_switch() {
    local mode=$1
    local static_yaml="/etc/netplan/02-netcfg-static.yaml"
    local static_disabled="/etc/netplan/02-netcfg-static.disabled"
    local dhcp_yaml="/etc/netplan/01-netcfg-dhcp.yaml"
    local dhcp_disabled="/etc/netplan/01-netcfg-dhcp.disabled"

    if [[ "$mode" == "static" ]]; then
        echo "Preparing Static IP configuration..."
        
        # 1. Ensure the static file is active (.yaml) before editing/applying
        if [[ -f "$static_disabled" ]]; then
            sudo mv "$static_disabled" "$static_yaml"
        fi
        
        # 2. Open the editor and WAIT
        echo "Opening $static_yaml for review/edit. Please close the editor when finished."
        sudo gnome-text-editor "$static_yaml"
        echo "Editor closed. Proceeding with configuration switch."

        # 3. Ensure the DHCP file is disabled, *if* it is currently active.
        if [[ -f "$dhcp_yaml" ]]; then
            sudo mv "$dhcp_yaml" "$dhcp_disabled"
        fi

    elif [[ "$mode" == "dhcp" ]]; then
        echo "Preparing DHCP configuration."

        # 1. Ensure the DHCP file is active, *if* it is currently disabled.
        if [[ -f "$dhcp_disabled" ]]; then
            sudo mv "$dhcp_disabled" "$dhcp_yaml"
        fi
        
        # 2. Ensure the Static file is disabled, *if* it is currently active.
        if [[ -f "$static_yaml" ]]; then
            sudo mv "$static_yaml" "$static_disabled"
        fi

    else
        echo "Usage: mw-nplan_mode_switch [static|dhcp]"
        return 1
    fi
    
    # Apply changes (using your alias which includes the wait loop)
    mw-nplan-br0
}
