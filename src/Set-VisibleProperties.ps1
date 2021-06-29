function Set-VisibleProperties {
    param (
        [string[]]$values,
        [Parameter(ValueFromPipeline)]
        $InputObject
    )
    process{
        [Management.Automation.PSMemberInfo[]]$info = [System.Management.Automation.PSPropertySet]::new('DefaultDisplayPropertySet', $values)
        $InputObject |  Add-Member -MemberType MemberSet -Name PSStandardMembers -Value $info 
        Return $InputObject
    }
}
