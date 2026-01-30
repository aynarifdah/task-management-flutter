import 'package:flutter/material.dart';


//ini untuk titik masuk aplikasi atau sebagai function utama 
void main() {
  runApp(const MyApp());
}

//ini model data task supaya bukan sekedar string saja atau hardcode di model
class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});
}


//ini cuma untuk setup awal aplikasi aja dan menampilkan halaman utama
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // ini kerangka utamanya atau isi dari class myapp
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // ini gunanya untuk hilangin banner debug dipojok atas
      home: const TaskPage(), // ini untuk manggil halaman utama nya kemana
    );
  }
}

class TaskPage extends StatefulWidget { //pake stateful karena datanya berubah ubah bisa di centang bisa ngga
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}


//ini logic nya ada disini 
class _TaskPageState extends State<TaskPage> {
  final TextEditingController _controller = TextEditingController(); // ini kegunaannya untuk ngambil data dari textfield atau dari inptan user
  final List<Task> tasks = []; // nah ini untuk nampung data task nya (simpanan sementara-memory)
  
  // fungsi untuk menampilkan task baru
  // LOGICNYA DISINI:
  void addTask() {
    if (_controller.text.isNotEmpty) { //cek inputan user kosong atau ngga
      setState(() { // ini untuk ngasih tau flutter kalo ada perubahan data, kalo ada data baru dia bakal ubah UI nya
        tasks.add(Task(title: _controller.text)); // tambahin task baru ke list task
        _controller.clear(); // ini untuk kosongin kolom input nya kalo task udah ditambahin
      });
    }
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( //ini kerangka halaman atau kalo di html itu body
      appBar: AppBar( // ini header app nya
        title: const Text('Task Management'), // ini judul header app nya
        centerTitle: true, // ini supaya judulnya di tengah
      ),

      // ini padding biar ga nempel ke pinggir si content nya
      body: Padding(
        padding: const EdgeInsets.all(16), // ini padding nya
        child: Column( // ini susun supaya kebawah list content nya
          children: [
            // Input Task
            Row( // ini supaya inputan sama button nya sejajar kesamping
              children: [
                Expanded(
                  // ini kolom inputan task nya
                  child: TextField( 
                    controller: _controller, // ini kegunaannya untuk ngambil data dari textfield atau dari inptan user
                    decoration: const InputDecoration(
                      hintText: 'Masukkan task...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton( // nahh button ini yang untuk nambahin task baru
                  onPressed: addTask, // alibinya, ketika button di klik dia akan manggil fungsi addtask
                  child: const Text('Add'),
                )
              ],
            ),

            const SizedBox(height: 20),

            // ini list task nya disini
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile( // ini supaya task nya bisa di centang atau checkboxnya tuh ini  
                    title: Text(
                      tasks[index].title,
                      //ini design nya, ketika di centang text nya jadi coret gitu atau artinya yaa selesai tasknya
                      style: TextStyle(
                        decoration: tasks[index].isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),

                    // ini logic checkbox nya, ketika di klik checkboxnya maka nanti akan update task nya gitu dan UI nya auto refresh
                    value: tasks[index].isDone,
                    onChanged: (value) {
                      setState(() {
                        tasks[index].isDone = value!;
                      });
                    },
                    
                    secondary: IconButton( // ini button hapus task
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteTask(index),
                    )
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
