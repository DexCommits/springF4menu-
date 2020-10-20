function CODEXLIST:CreateFont(name, size, weight)
    surface.CreateFont("CODEXLIST." .. name, {
      font = "Agency FB",
      size = size or 16,
      weight = weight or 580
     })
     end