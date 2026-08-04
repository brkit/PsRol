# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolAssignmentScope {
    [PsRolAssignmentScopeType]$type
    [PsRolTitle[]]$titles
    [bool]$manager
    [bool]$substitute
    [string[]]$functions
    [PsRolTitle[]]$excludedTitles
    [PsRolUser[]]$exceptedUsers

    PsRolAssignmentScope() {}
    
    PsRolAssignmentScope($Type, $Titles) {
        $this.type = $Type
        $this.titles = $Titles
    }

    PsRolAssignmentScope([object]$obj) {
        if ($obj.type) {
            $this.type = [PsRolAssignmentScopeType]$obj.type
        }
        if ($obj.titles) {
            $this.titles = foreach ($t in $obj.titles) { [PsRolTitle]::new($t) }
        }
        if ($null -ne $obj.manager) {
            $this.manager = [bool]$obj.manager
        }
        if ($null -ne $obj.substitute) {
            $this.substitute = [bool]$obj.substitute
        }
        if ($obj.functions) {
            $this.functions = foreach ($f in $obj.functions) { [string]$f }
        }
        if ($obj.excludedTitles) {
            $this.excludedTitles = foreach ($et in $obj.excludedTitles) { [PsRolTitle]::new($et) }
        }
        if ($obj.exceptedUsers) {
            $this.exceptedUsers = foreach ($eu in $obj.exceptedUsers) { [PsRolUser]::new($eu) }
        }
    }

    [string] ToString() {
        return $this.type.ToString()
    }
}