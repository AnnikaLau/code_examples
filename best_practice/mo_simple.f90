MODULE mo_simple
  
  USE mo_create, ONLY: nproma, dp1

  IMPLICIT NONE

  CONTAINS

    SUBROUTINE simple(var)
      
      INTEGER, INTENT(IN) :: var
      INTEGER             :: i
      REAL, TARGET        :: array(nproma)
      REAL, POINTER       :: ptr(:)
      TYPE(dp1)           :: b1
      
      !$ACC DATA COPYIN(b1)
     
      ALLOCATE(b1%y(nproma)) ! Has to be created also on GPU, otherwise CPU addresses will be used for the pointers
      ! alternative to ATTACH
      !$ACC ENTER DATA CREATE(b1%y)
      ALLOCATE(b1%x(nproma))    
      !$ACC ENTER DATA CREATE(b1%x)

      ! No need too add b1%y but it has to be present
      !$ACC KERNELS DEFAULT(none) PRESENT(b1) 
      b1%y(:) = 1.0
      !$ACC END KERNELS
 
      !$ACC KERNELS DEFAULT(none) PRESENT(b1)
      b1%x(:) = 0.0
      !$ACC END KERNELS
  
      ptr => array
      DO i = 1,nproma
        ptr(i) = 1.0
      END DO
      
      WRITE(*,*) 'var', var
      PRINT *, 'ptr', ptr
      PRINT *, 'array', array

      !$ACC UPDATE HOST( b1%y, b1%x )
      PRINT *, 'b1%y', b1%y, 'b1%x', b1%x

      !$ACC KERNELS DEFAULT(none) PRESENT( b1 )
      b1%x(:) = b1%y(:)
      !$ACC END KERNELS

      !$ACC UPDATE HOST( b1%y, b1%x )
      PRINT *, 'b1%y', b1%y, 'b1%x', b1%x
      
      !$pgi compare( b1%x, b1%y )

      !$ACC END DATA !b1

    END SUBROUTINE simple

END MODULE mo_simple
