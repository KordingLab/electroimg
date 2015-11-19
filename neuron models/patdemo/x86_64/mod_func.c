#include <stdio.h>
#include "hocdec.h"
extern int nrnmpi_myid;
extern int nrn_nobanner_;

extern void _ca_reg(void);
extern void _cad_reg(void);
extern void _kca_reg(void);
extern void _km_reg(void);
extern void _kv_reg(void);
extern void _na_reg(void);

void modl_reg(){
  if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
    fprintf(stderr, "Additional mechanisms from files\n");

    fprintf(stderr," ca.mod");
    fprintf(stderr," cad.mod");
    fprintf(stderr," kca.mod");
    fprintf(stderr," km.mod");
    fprintf(stderr," kv.mod");
    fprintf(stderr," na.mod");
    fprintf(stderr, "\n");
  }
  _ca_reg();
  _cad_reg();
  _kca_reg();
  _km_reg();
  _kv_reg();
  _na_reg();
}
