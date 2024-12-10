root = exports ? this
# !!!! Hotpoor root object
root.Hs or= {}
Hs = root.Hs

$("body").on "click",".pixel_box_tools_area_btn_clean",(evt)->
    $(".pixel_box_tools_area_canvas_areas").html $(".pixel_box_tools_area_canvas_areas").html()
$("body").on "click",".pixel_box_tools_area_btn_calc",(evt)->
    pixel_box_diameter = $(".pixel_box_diameter").val()
    pixel_box_fps = $(".pixel_box_fps").val()
    pixel_box_rows = $(".pixel_box_rows").val()
    pixel_box_columns = $(".pixel_box_columns").val()
    pixel_box_points_padding_left_right = $(".pixel_box_points_padding_left_right").val()
    pixel_box_points_padding_top_bottom = $(".pixel_box_points_padding_top_bottom").val()

    pixel_box_diameter = parseFloat(pixel_box_diameter)
    pixel_box_fps = parseFloat(pixel_box_fps)
    pixel_box_rows = parseFloat(pixel_box_rows)
    pixel_box_columns = parseFloat(pixel_box_columns)
    pixel_box_points_padding_left_right = parseFloat(pixel_box_points_padding_left_right)
    pixel_box_points_padding_top_bottom = parseFloat(pixel_box_points_padding_top_bottom)


    范围长 = pixel_box_columns*pixel_box_fps*pixel_box_diameter - pixel_box_diameter*pixel_box_fps + pixel_box_diameter
    范围高 = pixel_box_rows*pixel_box_fps*pixel_box_diameter - pixel_box_diameter*pixel_box_fps + pixel_box_diameter
    纸总长 = 范围长 + pixel_box_points_padding_left_right*2
    纸总高 = 范围高 + pixel_box_points_padding_top_bottom*2

    $(".pixel_box_points_width").text 范围长
    $(".pixel_box_points_height").text 范围高
    $(".pixel_box_points_width_all").text 纸总长
    $(".pixel_box_points_height_all").text 纸总高
    
    $("#pixel_box_tools_area_canvas_area_0").attr
        "width":纸总长*10
        "height":纸总高*10
    $("#pixel_box_tools_area_canvas_area_1").attr
        "width":纸总长*10
        "height":纸总高*10
    $("#pixel_box_tools_area_canvas_area_0").css
        "width":纸总长
        "height":纸总高
    $("#pixel_box_tools_area_canvas_area_1").css
        "width":纸总长
        "height":纸总高
    $(".pixel_box_tools_area_btn_generates").empty()
    for i in [0..pixel_box_fps-1]
        $(".pixel_box_tools_area_btn_generates").append """
        <button class="pixel_box_tools_area_btn_generate" data-fps="#{i}">生成 第#{i+1}帧</button>
        """
$("body").on "click",".pixel_box_tools_area_btn_generate",(evt)->
    if $(".pixel_box_tools_area_btn_image")[0].files.length==0
        alert "请选择图片"
        return
    current_fps_index = $(this).attr "data-fps"
    current_fps_index = parseInt(current_fps_index)
    console.log "正在生成第#{current_fps_index+1}帧"
    pixel_type = "方块"
    picture = $(".pixel_box_tools_area_btn_image")[0].files[0]
    reader = new FileReader()
    reader.readAsDataURL(picture)
    reader.onload = ()->
        image = new Image()
        image.src =reader.result
        console.log(image)
        $(".log").append image
        image.onload = ()->
            pixel_box_diameter = $(".pixel_box_diameter").val()
            pixel_box_fps = $(".pixel_box_fps").val()
            pixel_box_rows = $(".pixel_box_rows").val()
            pixel_box_columns = $(".pixel_box_columns").val()
            pixel_box_points_padding_left_right = $(".pixel_box_points_padding_left_right").val()
            pixel_box_points_padding_top_bottom = $(".pixel_box_points_padding_top_bottom").val()

            pixel_box_diameter = parseFloat(pixel_box_diameter)
            pixel_box_fps = parseFloat(pixel_box_fps)
            pixel_box_rows = parseFloat(pixel_box_rows)
            pixel_box_columns = parseFloat(pixel_box_columns)
            pixel_box_points_padding_left_right = parseFloat(pixel_box_points_padding_left_right)
            pixel_box_points_padding_top_bottom = parseFloat(pixel_box_points_padding_top_bottom)
            范围长 = pixel_box_columns*pixel_box_fps*pixel_box_diameter - pixel_box_diameter*pixel_box_fps + pixel_box_diameter
            范围高 = pixel_box_rows*pixel_box_fps*pixel_box_diameter - pixel_box_diameter*pixel_box_fps + pixel_box_diameter
            纸总长 = 范围长 + pixel_box_points_padding_left_right*2
            纸总高 = 范围高 + pixel_box_points_padding_top_bottom*2
            console.log "纸总长:",纸总长,";纸总高:",纸总高
            for i in [0..pixel_box_columns-1]
                for j in [0..pixel_box_rows-1]
                    #console.log "正在获取点",i,j
                    canvas = $("#pixel_box_tools_area_canvas_area_1")[0]
                    context = canvas.getContext('2d')
                    ctx = context
                    dis = pixel_box_fps*pixel_box_diameter*10
                    ctx.fillStyle="white"
                    ctx.beginPath()
                    ctx.fillRect(pixel_box_points_padding_left_right*10+dis*i,pixel_box_points_padding_top_bottom*10+dis*j,pixel_box_diameter*10,pixel_box_diameter*10)
                    ctx.closePath()
                    ctx.fill()
            canvas = $("#pixel_box_tools_area_canvas_area_1")[0]
            context = canvas.getContext('2d')
            context.globalCompositeOperation = "source-in"
            context.drawImage(image, pixel_box_diameter*10*current_fps_index, 0, 纸总长*10, 纸总高*10)
            console.log image, pixel_box_diameter*10*current_fps_index, 0, 纸总长*10, 纸总高*10
            img = canvas.toDataURL("image/png", 1)
            image_current = new Image()
            sourceCanvas = $("#pixel_box_tools_area_canvas_area_1")[0]
            image_current.src = sourceCanvas.toDataURL('image/png')
            destinationCanvas = $("#pixel_box_tools_area_canvas_area_0")[0]
            destinationCtx = destinationCanvas.getContext('2d')
            destinationCtx.drawImage(image_current, 0, 0)
            $(".log").append image_current