#if swift(<5.7)
extension Error where Self:Equatable
{
    private
    func equals(_ other:Error) -> Bool
    {
        (other as? Self).map { $0 == self } ?? false
    }
}
extension Error
{
    public static
    func == (lhs:Self, rhs:Error) -> Bool
    {
        if let lhs:Error & Equatable = lhs as? Error & Equatable
        {
            return lhs.equals(rhs)
        }
        else
        {
            return false
        }
    }
}
extension Error
{
    static
    func bold(_ string:String) -> String
    {
        "\u{1B}[1m\(string)\u{1B}[0m"
    }
    static
    func color(_ string:String) -> String 
    {
        let color:(r:UInt8, g:UInt8, b:UInt8) = (r: 255, g:  51, b:  51)
        return "\u{1B}[38;2;\(color.r);\(color.g);\(color.b)m\(string)\u{1B}[39m"
    }

    fileprivate
    func description(notes:[String]) -> String
    {
        var description:String
        if      let error:NamedError = self as? NamedError
        {
            description = error.description
        }
        else if let error:CustomStringConvertible = self as? CustomStringConvertible,
                   !error.description.isEmpty
        {
            description = "\(Self.bold(Self.color("\(Self.self):"))) \(error.description)"
        }
        else
        {
            description = "\(Self.bold(Self.color("\(Self.self):"))) (no description available)"
        }
        for note:String in notes.reversed()
        {
            description += "\n\(Self.bold("Note:")) \(note)"
        }
        return description
    }
}

/// A link in a propogated error.
public 
protocol TraceableError:CustomStringConvertible, Error 
{
    var underlying:Error { get }
    /// Context associated with this error. The *last* note will be printed *first*,
    /// after information related to the ``underlying`` error has been printed.
    var notes:[String] { get }
}

extension TraceableError
{
    public 
    var description:String 
    {
        var notes:[String] = []
        var current:TraceableError = self 
        while true
        {
            notes.append(contentsOf: current.notes)

            switch current.underlying
            {
            case let next as TraceableError:
                current = next
            case let last:
                return last.description(notes: notes)
            }
        }
    }
}
#endif
