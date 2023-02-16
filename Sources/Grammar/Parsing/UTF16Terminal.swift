/// A terminal type that can match a UTF-16 code unit pattern.
public 
protocol UTF16Terminal:ASCIITerminal
{
    init(_:UInt16)
}
extension UInt16:UTF16Terminal 
{
}
