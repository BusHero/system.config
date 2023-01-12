Rule 'PS.FileType' -Type 'System.IO.FileInfo' {
    $Assert.NotIn($TargetObject, 'Extension', @('.jpg', '.png'))
}
