/// A terminal type that can match an ASCII pattern.
/// 
/// For example, both a UTF-16 ``Unicode/UTF16//CodeUnit`` and a UTF-8 
/// ``Unicode/UTF8//CodeUnit`` can be matched against the terminal 
/// ``UnicodeEncoding//A``.
public 
protocol ASCIITerminal:Equatable
{
    init(_:UInt8)
}
/// A terminal type that can match a UTF-8 code unit pattern.
/// 
/// For example, a ``Unicode//UTF8/CodeUnit`` can match the UTF-8 
/// continuation byte [`0x80`](), but it would not make sense to 
/// match it against a ``Unicode//UTF16/CodeUnit``.
public 
protocol UTF8Terminal:ASCIITerminal
{
}
/// A terminal type that can match a UTF-16 code unit pattern.
public 
protocol UTF16Terminal:ASCIITerminal
{
    init(_:UInt16)
}
/// A terminal type that can match a ``Unicode/Scalar`` pattern.
public 
protocol UnicodeTerminal:ASCIITerminal
{
    init(_:Unicode.Scalar)
}
/// A terminal type that can match a ``Character`` pattern.
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
extension Unicode.Scalar:UnicodeTerminal 
{
}
/* extension Character:CharacterTerminal 
{
} */