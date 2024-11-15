/// A terminal type that can match a UTF-8 code unit pattern.
///
/// For example, a ``Unicode/UTF8.CodeUnit`` can match the UTF-8
/// continuation byte `0x80`, but it would not make sense to
/// match it against a ``Unicode/UTF16.CodeUnit``.
public
protocol UTF8Terminal:ASCIITerminal
{
}
extension UInt8:UTF8Terminal
{
}

