# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
enum PsRolItSystemType {
    AD
    MANUAL
    SAML
    # The following values are systemtypes maintained by Rollekatalog itself and should not be used when writing to the API.
    KOMBIT
    KSPCICS
    NEMLOGIN
}