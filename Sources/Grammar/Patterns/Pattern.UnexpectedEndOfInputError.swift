extension Pattern
{
    @frozen public
    struct UnexpectedEndOfInputError:Equatable, Error 
    {
        @inlinable public 
        init() 
        {
        }
    }
}
