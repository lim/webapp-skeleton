describe 'foo.hello', ->
  it 'can say hello to the world', ->
    actual = hello()
    expected = 'Hello, world!'
    expect(actual).toBe expected

  it 'can say hello to John', ->
    actual = hello 'John'
    expected = 'Hello, John!'
    expect(actual).toBe expected
