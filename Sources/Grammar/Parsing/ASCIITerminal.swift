/// A terminal type that can match an ASCII pattern.
/// 
/// For example, both a UTF-16 ``Unicode.UTF16 CodeUnit`` and a UTF-8 
/// ``Unicode.UTF8 CodeUnit`` can be matched against the terminal 
/// ``UnicodeEncoding A``.
public 
protocol ASCIITerminal:Equatable
{
    init(_:UInt8)
}

extension UInt8:ASCIITerminal
{
}
extension UInt16:ASCIITerminal 
{
}
extension Unicode.Scalar:ASCIITerminal 
{
}
