import pika
import json

# Fungsi untuk mengirim pesan ke RabbitMQ
def publish_message(message):
    # Buat koneksi ke RabbitMQ
    connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
    channel = connection.channel()

    # Deklarasi pertukaran (exchange) RabbitMQ
    channel.exchange_declare(exchange='product_events', exchange_type='fanout')

    # Konversi pesan menjadi format JSON
    json_message = json.dumps(message)

    # Publish pesan ke pertukaran RabbitMQ
    channel.basic_publish(exchange='product_events', routing_key='', body=json_message)

    print(" [x] Sent message:", message)

    # Tutup koneksi ke RabbitMQ
    connection.close()

# Contoh class untuk mengelola data produk
class ProductService:
    def __init__(self):
        # Simpan data produk dalam dictionary
        self.products = {}

    # Fungsi untuk menambah produk baru
    def add_product(self, product_id, name, price):
        self.products[product_id] = {'name': name, 'price': price}
        # Publikasikan pesan ke RabbitMQ saat produk ditambahkan
        product_event = {'event': 'product_added', 'product_id': product_id, 'name': name, 'price': price}
        publish_message(product_event)

    # Fungsi untuk menghapus produk
    def delete_product(self, product_id):
        if product_id in self.products:
            del self.products[product_id]
            # Publikasikan pesan ke RabbitMQ saat produk dihapus
            product_event = {'event': 'product_deleted', 'product_id': product_id}
            publish_message(product_event)

# Fungsi untuk memulai layanan produk
def start_product_service():
    # Buat instance ProductService
    product_service = ProductService()

    # Contoh penggunaan: Tambahkan produk baru
    product_service.add_product('111', 'Produk g', 500)

    # Contoh penggunaan: Hapus produk
    product_service.delete_product('456')

# Mulai layanan produk
if __name__ == "__main__":
    start_product_service()
