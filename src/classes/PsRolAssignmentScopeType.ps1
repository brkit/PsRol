# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolAssignmentScope {
    [PsRolAssignmentScopeType]$type
    [PsRolTitle[]]$titles

    PsRolAssignmentScope() {}
    
    PsRolAssignmentScope($Type, $Titles) {
        $this.Type = $Type
        $this.Titles = $Titles
    }
}