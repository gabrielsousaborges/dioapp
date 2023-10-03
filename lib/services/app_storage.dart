import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

enum STORAGE_CHAVES {
  CHAVE_DADOS_CADASTRAIS_NOME,
  CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO,
  CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA,
  CHAVE_DADOS_CADASTRAIS_LINGUAGENS,
  CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA,
  CHAVE_DADOS_CADASTRAIS_SALARIO,
  CHAVE_CONFIGURACAO_USUARIO,
  CHAVE_CONFIGURACAO_ALTURA,
  CHAVE_CONFIGURACAO_NOTIFICACAO,
  CHAVE_CONFIGURACAO_TEMA,
  CHAVE_NUMEROALEATORIO,
  CHAVE_QUANTIDADESCLIQUES,
}

class AppStorageService {
  Future<void> setDadosCadastraisNome(String nome) async {
    await _setString(
        STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_NOME.toString(), nome);
  }

  Future<String> getDadosCadastraisNome() async {
    return _getString(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_NOME.toString());
  }

  Future<void> setDadosCadastraisDataNascimento(DateTime data) async {
    await _setString(
        STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO.toString(),
        data.toString());
  }

  Future<String> getDadosCadastraisDataNascimento() async {
    return _getString(
        STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO.toString());
  }

  Future<void> setDadosCadastraisNivelExperiencia(String nivel) async {
    await _setString(
        STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA.toString(),
        nivel.toString());
  }

  Future<String> getDadosCadastraisNivelExperiencia() async {
    return _getString(
        STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA.toString());
  }

  Future<void> setDadosCadastraisLinguagens(List<String> values) async {
    await _setStringList(
        STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_LINGUAGENS.toString(), values);
  }

  Future<List<String>> getDadosCadastraisLinguagens() async {
    return _getStringList(
        STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_LINGUAGENS.toString());
  }

  Future<void> setDadosCadastraisTempoExperiencia(int values) async {
    await _setInt(
        STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA.toString(),
        values);
  }

  Future<int> getDadosCadastraisTempoExperiencia() async {
    return _getInt(
        STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA.toString());
  }

  Future<void> setDadosCadastraisSalario(double values) async {
    await _setDouble(
        STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA.toString(),
        values);
  }

  Future<double> getDadosCadastraisSalario() async {
    return _getDouble(
        STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA.toString());
  }

  Future<void> setConfiguracaoUsuario(String usuario) async {
    await _setString(
        STORAGE_CHAVES.CHAVE_CONFIGURACAO_USUARIO.toString(), usuario);
  }

  Future<String> getConfiguracaoUsuario() async {
    return _getString(STORAGE_CHAVES.CHAVE_CONFIGURACAO_USUARIO.toString());
  }

  Future<void> setConfiguracaoAltura(double altura) async {
    await _setDouble(
        STORAGE_CHAVES.CHAVE_CONFIGURACAO_ALTURA.toString(), altura);
  }

  Future<double> getConfiguracaoAltura() async {
    return _getDouble(STORAGE_CHAVES.CHAVE_CONFIGURACAO_ALTURA.toString());
  }

  Future<void> setConfiguracaoNotificacao(bool notificao) async {
    await _setBool(
        STORAGE_CHAVES.CHAVE_CONFIGURACAO_NOTIFICACAO.toString(), notificao);
  }

  Future<bool> getConfiguracaoNotificacao() async {
    return _getBool(STORAGE_CHAVES.CHAVE_CONFIGURACAO_NOTIFICACAO.toString());
  }

  Future<void> setConfiguracaoTema(bool tema) async {
    await _setBool(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_NOME.toString(), tema);
  }

  Future<bool> getConfiguracaoTema() async {
    return _getBool(STORAGE_CHAVES.CHAVE_CONFIGURACAO_TEMA.toString());
  }

  Future<void> setNumeroAleatorio(int numero) async {
    await _setInt(STORAGE_CHAVES.CHAVE_NUMEROALEATORIO.toString(), numero);
  }

  Future<int> getNumeroAleatorio() async {
    return _getInt(STORAGE_CHAVES.CHAVE_NUMEROALEATORIO.toString());
  }

  Future<void> setQuantidadeCliques(int quantidadeCliques) async {
    await _setInt(
        STORAGE_CHAVES.CHAVE_QUANTIDADESCLIQUES.toString(), quantidadeCliques);
  }

  Future<int> getQuantidadeCliques() async {
    return _getInt(STORAGE_CHAVES.CHAVE_QUANTIDADESCLIQUES.toString());
  }

  _setString(String chave, String value) async {
    var storage = await SharedPreferences.getInstance();

    storage.setString(chave, value);
  }

  Future<String> _getString(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(chave) ?? "";
  }

  _setStringList(String chave, List<String> values) async {
    var storage = await SharedPreferences.getInstance();

    storage.setStringList(chave, values);
  }

  Future<List<String>> _getStringList(String chaves) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getStringList(chaves) ?? [];
  }

  _setInt(String chave, int values) async {
    var storage = await SharedPreferences.getInstance();

    storage.setInt(chave, values);
  }

  Future<int> _getInt(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getInt(chave) ?? 0;
  }

  _setDouble(String chave, double values) async {
    var storage = await SharedPreferences.getInstance();

    storage.setDouble(chave, values);
  }

  Future<double> _getDouble(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getDouble(chave) ?? 0;
  }

  _setBool(String chave, bool values) async {
    var storage = await SharedPreferences.getInstance();

    storage.setBool(chave, values);
  }

  Future<bool> _getBool(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getBool(chave) ?? false;
  }
}
