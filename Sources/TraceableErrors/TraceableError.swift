extension Error where Self:Equatable
{
    private
    func equals(_ other:any Error) -> Bool
    {
        (other as? Self).map { $0 == self } ?? false
    }
}
extension Error
{
    public static
    func == (lhs:Self, rhs:any Error) -> Bool
    {
        if let lhs:any Error & Equatable = lhs as? any Error & Equatable
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

    public
    func headline(plaintext:Bool = true) -> String
    {
        if      let self:any NamedError = self as? any NamedError
        {
            return plaintext ? self.description :
                "\(Self.bold(Self.color("\(self.name):"))) \(self.message)"
        }
        else if let error:any CustomStringConvertible = self as? any CustomStringConvertible,
                   !error.description.isEmpty
        {
            return plaintext ? "\(Self.self): \(error.description)" :
                "\(Self.bold(Self.color("\(Self.self):"))) \(error.description)"
        }
        else
        {
            return plaintext ? "\(Self.self): (no description available)" :
                "\(Self.bold(Self.color("\(Self.self):"))) (no description available)"
        }
    }
    fileprivate
    func description(notes:[String], plaintext:Bool = true) -> String
    {
        var description:String = self.headline(plaintext: plaintext)
        for note:String in notes.reversed()
        {
            description += "\n\(plaintext ? "Note:" : Self.bold("Note:")) \(note)"
        }
        return description
    }
}

/// A link in a propogated error.
public 
protocol TraceableError:CustomStringConvertible, Error 
{
    var underlying:any Error { get }
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
        var current:any TraceableError = self 
        while true
        {
            notes.append(contentsOf: current.notes)

            switch current.underlying
            {
            case let next as any TraceableError:
                current = next
            case let last:
                return last.description(notes: notes, plaintext: false)
            }
        }
    }
}
