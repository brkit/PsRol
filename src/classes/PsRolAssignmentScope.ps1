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
}