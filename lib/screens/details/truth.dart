import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:truth_or_dare/api_service/service.dart';

class TruthScreen extends StatefulWidget {
  @override
  _TruthScreenState createState() => _TruthScreenState();
}

class _TruthScreenState extends State<TruthScreen> {
  String _question = 'Press "New Question" to start';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadQuestion() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final question = await TruthQuestionFetcher.fetchQuestion();
      setState(() {
        _question = question;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _question = 'Failed to load question: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[50], // AppBar background color
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios,
              color: const Color.fromARGB(255, 20, 20, 20)),
        ),
        title: Text('Truth',
            style: TextStyle(
                color: Color.fromARGB(255, 109, 63, 144),
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.purple[50], // Light purple background
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isLoading
                    ? CircularProgressIndicator()
                    : SingleChildScrollView(
                        child: Center(
                          child: Text(
                            _question,
                            style: TextStyle(
                              fontSize:
                                  20, // Increased font size for better readability
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple[800], // Dark purple text
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                SizedBox(height: 30), // More space before the button
                ElevatedButton(
                  onPressed: _isLoading ? null : _loadQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.deepPurple[700], // Deep purple button
                    foregroundColor:
                        Colors.amber[300], // Gold button text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  ),
                  child: Text(
                    'New Question',
                    style: TextStyle(fontSize: 18.0), // Slightly larger text
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
