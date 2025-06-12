package sewaalatcamping;

import java.sql.Date;

public class Penyewaan {
    private int id;
    private int idPelanggan;
    private Date tanggalSewa;
    private Date tanggalKembali;
    private String status;

    public Penyewaan(int id, int idPelanggan, Date tanggalSewa, Date tanggalKembali, String status) {
        this.id = id;
        this.idPelanggan = idPelanggan;
        this.tanggalSewa = tanggalSewa;
        this.tanggalKembali = tanggalKembali;
        this.status = status;
    }

    public Penyewaan(int idPelanggan, Date tanggalSewa, Date tanggalKembali, String status) {
        this.idPelanggan = idPelanggan;
        this.tanggalSewa = tanggalSewa;
        this.tanggalKembali = tanggalKembali;
        this.status = status;
    }

    public int getId() { return id; }
    public int getIdPelanggan() { return idPelanggan; }
    public Date getTanggalSewa() { return tanggalSewa; }
    public Date getTanggalKembali() { return tanggalKembali; }
    public String getStatus() { return status; }

    public void setId(int id) { this.id = id; }
    public void setIdPelanggan(int idPelanggan) { this.idPelanggan = idPelanggan; }
    public void setTanggalSewa(Date tanggalSewa) { this.tanggalSewa = tanggalSewa; }
    public void setTanggalKembali(Date tanggalKembali) { this.tanggalKembali = tanggalKembali; }
    public void setStatus(String status) { this.status = status; }
}
