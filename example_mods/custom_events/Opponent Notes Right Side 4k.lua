function onEvent(name)
    if name == 'Opponent Notes Right Side 4k' and not middlescroll then
        setPropertyFromGroup('playerStrums', 0, 'x', defaultOpponentStrumX0)
        setPropertyFromGroup('playerStrums', 1, 'x', defaultOpponentStrumX1)
        setPropertyFromGroup('playerStrums', 2, 'x', defaultOpponentStrumX2)
        setPropertyFromGroup('playerStrums', 3, 'x', defaultOpponentStrumX3)

        setPropertyFromGroup('opponentStrums', 0, 'x', defaultPlayerStrumX0)
        setPropertyFromGroup('opponentStrums', 1, 'x', defaultPlayerStrumX1)
        setPropertyFromGroup('opponentStrums', 2, 'x', defaultPlayerStrumX2)
        setPropertyFromGroup('opponentStrums', 3, 'x', defaultPlayerStrumX3)
    end
end