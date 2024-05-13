import pika
import json

# Fungsi yang akan dipanggil saat menerima pesan
def callback(ch, method, properties, body):
    # Konversi pesan dari format JSON
    message = json.loads(body)
    print(" [x] Received message:", message)

    # Periksa jenis peristiwa produk
    if message['event'] == 'product_added':
        # Lakukan tindakan yang sesuai, misalnya, memperbarui informasi pembayaran
        update_payment_info(message['product_id'], message['price'])
    elif message['event'] == 'product_deleted':
        # Lakukan tindakan yang sesuai, misalnya, menghapus produk dari informasi pembayaran
        remove_product_from_payment_info(message['product_id'])

# Fungsi untuk memperbarui informasi pembayaran ketika produk ditambahkan
def update_payment_info(product_id, price):
    print(f"Product {product_id} added with price {price}. Updating payment information...")

# Fungsi untuk menghapus informasi pembayaran ketika produk dihapus
def remove_product_from_payment_info(product_id):
    print(f"Product {product_id} deleted. Removing product from payment information...")

# Fungsi untuk memulai langganan ke RabbitMQ
def start_payment_service():
    # Buat koneksi ke RabbitMQ
    connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
    channel = connection.channel()

    # Deklarasi pertukaran (exchange) RabbitMQ
    channel.exchange_declare(exchange='product_events', exchange_type='fanout')

    # Buat antrian (queue) yang terikat ke pertukaran
    result = channel.queue_declare(queue='payment_service_queue', durable=True)  # Deklarasi antrian persisten
    queue_name = result.method.queue
    channel.queue_bind(exchange='product_events', queue=queue_name)

    # Mulai konsumsi pesan dari RabbitMQ
    print(' [*] Waiting for messages. To exit press CTRL+C')
    channel.basic_consume(queue=queue_name, on_message_callback=callback, auto_ack=True)

    # Jalankan loop untuk mendengarkan pesan
    channel.start_consuming()

# Mulai layanan pembayaran
if __name__ == "__main__":
    start_payment_service()
