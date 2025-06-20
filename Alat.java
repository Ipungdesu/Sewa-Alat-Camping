package sewaalatcamping;

public class Alat {
    private int id;
    private String nama;
    private int idKategori;
    private int stok;
    private double hargaSewa;

    public Alat(int id, String nama, int idKategori, int stok, double hargaSewa) {
        this.id = id;
        this.nama = nama;
        this.idKategori = idKategori;
        this.stok = stok;
        this.hargaSewa = hargaSewa;
    }

    public Alat(String nama, int idKategori, int stok, double hargaSewa) {
        this.nama = nama;
        this.idKategori = idKategori;
        this.stok = stok;
        this.hargaSewa = hargaSewa;
    }

    public int getId() { return id; }
    public String getNama() { return nama; }
    public int getIdKategori() { return idKategori; }
    public int getStok() { return stok; }
    public double getHargaSewa() { return hargaSewa; }

    public void setId(int id) { this.id = id; }
    public void setNama(String nama) { this.nama = nama; }
    public void setIdKategori(int idKategori) { this.idKategori = idKategori; }
    public void setStok(int stok) { this.stok = stok; }
    public void setHargaSewa(double hargaSewa) { this.hargaSewa = hargaSewa; }
}
