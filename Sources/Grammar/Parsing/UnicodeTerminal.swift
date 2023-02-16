/// A terminal type that can match a ``Unicode.Scalar`` pattern.
public 
protocol UnicodeTerminal:ASCIITerminal
{
    init(_:Unicode.Scalar)
}
extension Unicode.Scalar:UnicodeTerminal 
{
}
