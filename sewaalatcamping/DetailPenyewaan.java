package sewaalatcamping;

public class DetailPenyewaan {
    private int id;
    private int idPenyewaan;
    private int idAlat;
    private int jumlah;
    private double hargaPerhari;

    public DetailPenyewaan(int id, int idPenyewaan, int idAlat, int jumlah, double harga_perhari) {
        this.id = id;
        this.idPenyewaan = idPenyewaan;
        this.idAlat = idAlat;
        this.jumlah = jumlah;
        this.hargaPerhari = harga_perhari;
    }

    public DetailPenyewaan(int idPenyewaan, int idAlat, int jumlah, double harga_perhari) {
        this.idPenyewaan = idPenyewaan;
        this.idAlat = idAlat;
        this.jumlah = jumlah;
        this.hargaPerhari = harga_perhari;
    }

    public int getId() { return id; }
    public int getIdPenyewaan() { return idPenyewaan; }
    public int getIdAlat() { return idAlat; }
    public int getJumlah() { return jumlah; }
    public double getHargaPerhari() { return hargaPerhari; }

    public void setId(int id) { this.id = id; }
    public void setIdPenyewaan(int idPenyewaan) { this.idPenyewaan = idPenyewaan; }
    public void setIdAlat(int idAlat) { this.idAlat = idAlat; }
    public void setJumlah(int jumlah) { this.jumlah = jumlah; }
    public void setHargaPerhari(double hargaPerhari) { this.hargaPerhari = hargaPerhari; }
}
