defprotocol Pippo.Interpreter.Object.Object do
  @doc "Return the type of the object as a string"
  def type(obj)

  @doc "Return the value of the object as a string"
  def inspect(obj)
end
