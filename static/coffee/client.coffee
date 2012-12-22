$(document).ready () ->
    cvs = $('#Canvas')[0]
    ctx = cvs.getContext '2d'
    g_size = 50
    g_queens = []

    create_board = (wh, size) ->
        num = [0..wh-1]
        for x in num
            for y in num
                if (x + y) % 2 is 0
                    ctx.fillStyle = "GRAY"
                else
                    ctx.fillStyle = "#DDD"
                ctx.fillRect(x*size, y*size, size, size)

    draw_queen = (pos, size) ->
        x = pos[0]
        y = pos[1]
        console.log x, y
        ctx.beginPath()
        ctx.fillStyle = 'RED'
        ctx.moveTo x+2, y+2
        ctx.lineTo x+size/4, y+size/2
        ctx.lineTo x+size/2, y+2
        ctx.lineTo x+size*3/4, y+size/2
        ctx.lineTo x+size-2, y+2
        ctx.lineTo x+size-2, y+size*2/3
        ctx.lineTo x+2, y+size*2/3
        ctx.fill()
        ctx.fillRect(x+2, y+size*3/4, size-4, size/5)
        ctx.fill()


    draw_queens = (poss, size) ->
        for x in [0..poss.length-1]
            draw_queen([x*size, poss[x]*size], size)

    $('#create_board').live 'click', ->
        $('#show_queen').remove()
        $('#solu_num').remove()
        ctx.clearRect(0, 0, cvs.width, cvs.height)
        wh = $('#queens')[0].value
        create_board wh, g_size
        $.post '/', {n:wh}, (res) ->
            g_queens = res.solu
            $('#create_board').after('<button id="show_queen">点击显示摆放方案</button><p id="solu_num">共'+g_queens.length+'种方案</p>')

    $('#show_queen').live 'click', ->
        if g_queens.length > 0
            wh = $('#queens')[0].value
            create_board wh, g_size
            poss = g_queens.pop()
            draw_queens poss, g_size
            $('#solu_num').html('剩余'+g_queens.length+'种方案')
