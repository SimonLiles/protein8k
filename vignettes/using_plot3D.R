## ----eval = TRUE, echo = FALSE------------------------------------------------
library(protein8k)

## ---- echo=FALSE--------------------------------------------------------------
plot3D(p53_tetramerization)

## -----------------------------------------------------------------------------
plot3D(p53_tetramerization, animated = TRUE)

## -----------------------------------------------------------------------------
plot3D(p53_tetramerization, type = "p")
plot3D(p53_tetramerization, type = "l")
plot3D(p53_tetramerization, type = "b")
plot3D(p53_tetramerization, type = "h")

## ---- echo=FALSE--------------------------------------------------------------
plot3D(p53_tetramerization, groups = residue_name)
plot3D(p53_tetramerization, groups = residue_seq_num)

## -----------------------------------------------------------------------------
plot3D(p53_tetramerization, screen = list())
plot3D(p53_tetramerization, screen = list(x = 30)) #X axis, 30 degrees
plot3D(p53_tetramerization, screen = list(y = 30)) #Y axis, 30 degrees
plot3D(p53_tetramerization, screen = list(z = 30)) #Z axis, 30 degrees

## -----------------------------------------------------------------------------
plot3D(p53_tetramerization, screen = list(z = -30, x = -60))

## -----------------------------------------------------------------------------
plot3D(p53_tetramerization, type = "l", groups = residue_name, 
       screen = list(z = -30, x = -60))
plot3D(p53_tetramerization, animated = TRUE, type = "l", groups = residue_name)

