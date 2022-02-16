using System;
using System.Collections.Generic;

[Serializable]
public class DialogReplica
{
    public string PersonName;
    public string Caption;
    public List<string> Replicas;
}

[Serializable]
public class Dialog
{
    public List<DialogReplica> DialogEntries;
}