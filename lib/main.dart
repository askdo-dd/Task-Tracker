import 'package:flutter/material.dart';

void main() {
  runApp(const TaskTrackerApp());
}

class TaskTrackerApp extends StatelessWidget {
  const TaskTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Тапсырмалар менеджері',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final TextEditingController controller = TextEditingController();

  final List<String> tasks = [];
  final List<String> completedTasks = [];

  void addTask() {
    if (controller.text.trim().isNotEmpty) {
      setState(() {
        tasks.add(controller.text.trim());
      });
      controller.clear();
    }
  }

  void completeTask(int index) {
    setState(() {
      completedTasks.add(tasks[index]);
      tasks.removeAt(index);
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      buildTasksPage(),
      buildCompletedPage(),
      buildProfilePage(),
      buildAboutPage(),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Тапсырмалар",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: "Аяқталған",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Профиль",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "Жоба",
          ),
        ],
      ),
    );
  }

  Widget buildTasksPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Тапсырмалар менеджері"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Тапсырманы енгізіңіз",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addTask,
                child: const Text("Қосу"),
              ),
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Барлығы",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("${tasks.length}"),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Аяқталған",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("${completedTasks.length}"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: tasks.isEmpty
                  ? const Center(
                      child: Text(
                        "Тапсырмалар жоқ",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: IconButton(
                              icon: const Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              ),
                              onPressed: () => completeTask(index),
                            ),
                            title: Text(tasks[index]),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () => deleteTask(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCompletedPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Аяқталған тапсырмалар"),
        centerTitle: true,
      ),
      body: completedTasks.isEmpty
          ? const Center(
              child: Text("Аяқталған тапсырмалар жоқ"),
            )
          : ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    title: Text(completedTasks[index]),
                  ),
                );
              },
            ),
    );
  }

  Widget buildProfilePage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Профиль"),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Бейбарыс Ахметов",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Ақпараттық жүйелер мамандығы",
            ),
          ],
        ),
      ),
    );
  }

 Widget buildAboutPage() {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Жоба туралы"),
      centerTitle: true,
    ),
    body: const SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Task Tracker",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 20),

          Text(
            "Task Tracker — күнделікті тапсырмаларды тиімді басқаруға арналған мобильді қосымша. Қосымша пайдаланушыларға өз тапсырмаларын жоспарлауға, олардың орындалу барысын бақылауға және аяқталған жұмыстарды сақтауға мүмкіндік береді.",
            style: TextStyle(fontSize: 16),
          ),

          SizedBox(height: 20),

          Text(
            "Жобаның мақсаты",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 10),

          Text(
            "Пайдаланушылардың уақытын тиімді ұйымдастыруға және күнделікті тапсырмаларды жүйелі түрде орындауға көмектесу.",
            style: TextStyle(fontSize: 16),
          ),

          SizedBox(height: 20),

          Text(
            "Негізгі мүмкіндіктері",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 10),

          Text("• Жаңа тапсырма қосу"),
          Text("• Тапсырманы жою"),
          Text("• Тапсырманы аяқталғандар тізіміне көшіру"),
          Text("• Орындалған тапсырмаларды қарау"),
          Text("• Тапсырмалар статистикасын бақылау"),

          SizedBox(height: 20),

          Text(
            "Қолданылған технологиялар",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 10),

          Text("• Flutter"),
          Text("• Dart"),
          Text("• Visual Studio Code"),
          Text("• Git және GitHub"),

          SizedBox(height: 20),

          Text(
            "Жоба авторы",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 10),

          Text(
            "Бейбарыс Ахметов",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),
  );
}
}