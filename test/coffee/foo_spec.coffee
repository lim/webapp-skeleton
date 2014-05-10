describe 'foo.hello', ->
  it 'can say hello to the world', ->
    actual = hello()
    expected = 'Hello, world!'
    expect(actual).toBe expected

  it 'can say hello to Jon', ->
    actual = hello 'Jon'
    expected = 'Hello, Jon!'
    expect(actual).toBe expected
