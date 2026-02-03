// lib/pages/home.dart

import 'package:flutter/material.dart';
import '../config/app_config.dart';
import '../templates/appbar.dart';
import '../services/finance_service.dart';
import '../services/client_service.dart';
import '../models/client.dart';
import '../tools/formatters.dart';
import 'client_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final String _status;
  final FinanceService _financeService = FinanceService();
  final ClientService _clientService = ClientService();

  final TextEditingController _searchController = TextEditingController();
  String _search = '';

  @override
  void initState() {
    super.initState();
    _status = 'UID ativo: ${AppConfig.fixedUid}';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: [
          // Resumo
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  Text('Total a receber'),
                  SizedBox(height: 8),
                  Text(
                    'R\$ 249,60',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Busca
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Buscar cliente',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Lista
          Expanded(
            child: ListView(
              children: const [
                ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text('Maria Aparecida'),
                  subtitle: Text('Saldo: R\$ 139,80'),
                  trailing: Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text('João Carlos'),
                  subtitle: Text('Saldo: R\$ 109,80'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),

          // Botão
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.person_add),
                label: const Text('Novo cliente'),
                onPressed: null, // depois ligamos
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: 'Pesquisar cliente...',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: _search.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _search = '';
                    });
                  },
                )
              : null,
        ),
        onChanged: (value) {
          setState(() {
            _search = value.toLowerCase();
          });
        },
      ),
    );
  }
}
