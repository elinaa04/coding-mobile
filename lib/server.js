const express = require("express");
const mysql = require("mysql");
const bodyParser = require("body-parser");

const app = express();
const port = 3301;

// Koneksi ke database MySQL
const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "islamiq",
});

db.connect((err) => {
    if (err) {
        console.error("Koneksi ke database gagal: " + err.stack);
        return;
    }
    console.log("Terhubung ke database MySQL dengan ID " + db.threadId);
});

// Middleware untuk mengizinkan CORS
app.use((req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header(
        "Access-Control-Allow-Methods",
        "GET, POST, OPTIONS, PUT, PATCH, DELETE"
    );
    res.header(
        "Access-Control-Allow-Headers",
        "Origin, X-Requested-With, Content-Type, Accept"
    );

    res.header("Access-Control-Allow-Credentials", "true");
    next();
});

app.use(bodyParser.json());

app.post("/loginsiswa", (req, res) => {
    const { nisn, password } = req.body;
    const query = "SELECT * FROM loginsiswa WHERE nisn = ? AND password = ?";
    db.query(query, [nisn, password], (err, results) => {
        if (err) {
            console.error("Gagal melakukan login: " + err.message);
            res.status(500).json({ error: "Gagal melakukan login" });
        } else {
            if (results.length > 0) {
                // User ditemukan, beri respons berhasil
                res.status(200).json({ message: "Login berhasil" });
            } else {
                // User tidak ditemukan atau password salah
                res.status(401).json({ error: "nisn atau password salah" });
            }
        }
    });
});

app.post("/profilesiswa", (req, res) => {
    const { nisn } = req.body;
    const query = "SELECT nama_lengkap, tanggal_lahir, jenis_kelamin, kelas FROM profilesiswa WHERE nisn = ?";

    db.query(query, [nisn], (err, results) => {
        if (err) {
            console.error("Error querying the database: " + err.message);
            res.status(500).json({ error: "Internal server error" });
        } else {
            if (results.length > 0) {
                // Data profil ditemukan, kirim respons dengan data profil
                const profileData = results[0];
                res.status(200).json({
                    'namaLengkap': profileData.nama_lengkap,
                    'tanggalLahir': profileData.tanggal_lahir,
                    'jenisKelamin': profileData.jenis_kelamin,
                    'kelas': profileData.kelas,
                });
            } else {
                // Data profil tidak ditemukan
                res.status(404).json({ error: "Data profil tidak ditemukan" });
            }
        }
    });
});

app.post("/updatepassword", (req, res) => {
    console.log("Menerima permintaan updatePassword:", req.body);

    const { oldPassword, newPassword } = req.body;
    // Gantilah "loginsiswa" dengan nama tabel yang sesuai pada database Anda
    const query = "UPDATE loginsiswa SET password = ? WHERE password = ?";

    db.query(query, [newPassword, oldPassword], (err, results) => {
        if (err) {
            console.error("Gagal melakukan pembaruan password: " + err.message);
            res.status(500).json({ error: "Gagal melakukan pembaruan password" });
        } else {
            console.log("Berhasil melakukan pembaruan password:", results);
            if (results.affectedRows > 0) {
                // Pembaruan password berhasil
                res.status(200).json({ message: "Pembaruan password berhasil" });
            } else {
                // Password lama tidak sesuai atau tidak ada pembaruan yang dilakukan
                res.status(401).json({ error: "Password lama tidak sesuai" });
            }
        }
    });
});

app.post("/editProfile", (req, res) => {
    const { nisn, namaLengkap, tanggalLahir, jenisKelamin, kelas } = req.body;
    const query = "UPDATE profilesiswa SET namaLengkap = ?, tanggalLahir = ?, jenisKelamin = ?, kelas = ? WHERE nisn = ?";
    // const query = "INSERT INTO profilesiswa (nisn, namaLengkap, tanggalLahir, jenisKelamin, kelas) VALUES (?, ?, ?, ?, ?)";

    db.query(query, [namaLengkap, tanggalLahir, jenisKelamin, kelas, nisn], (err, results) => {
        if (err) {
            console.error("Gagal menyimpan data edit profil: " + err.message);
            res.status(500).json({ error: "Gagal menyimpan data edit profil" });
        } else {
            // Periksa hasil query dan kirim respons
            if (results.affectedRows > 0) {
                res.status(200).json({ success: true, message: "Data edit profil berhasil disimpan" });
            } else {
                res.status(400).json({ success: false, message: "Gagal menyimpan data edit profil" });
            }
        }
    });
});


app.listen(port, () => {
    console.log(`Server berjalan di http://localhost:${port}`);
});