MODULE mo_create

  IMPLICIT NONE
  
  PUBLIC :: nproma, dp1

  INTEGER :: nproma=1
!$ACC DECLARE COPYIN( nproma )

  TYPE dp1
    REAL, POINTER :: x(:)
    REAL, POINTER :: y(:)
    INTEGER       :: len
  END TYPE dp1


END MODULE mo_create
