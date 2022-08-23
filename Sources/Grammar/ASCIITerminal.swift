/// A terminal type that can be matched against an ASCII scalar.
public 
protocol ASCIITerminal:Equatable
{
    init(_:UInt8)
}
public 
protocol UTF8Terminal:ASCIITerminal
{
}
public 
protocol UTF16Terminal:ASCIITerminal
{
    init(_:UInt16)
}
public 
protocol UnicodeTerminal:ASCIITerminal
{
    init(_:Unicode.Scalar)
}
public 
protocol CharacterTerminal:UnicodeTerminal
{
    init(_:Character)
}

extension UInt8:UTF8Terminal
{
}
extension UInt16:UTF16Terminal 
{
}
/* extension UInt32:UnicodeTerminal 
{
} */
extension Unicode.Scalar:UnicodeTerminal 
{
}
/* extension Character:CharacterTerminal 
{
} */