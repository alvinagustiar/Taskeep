import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/task.dart';
import '../models/reminder_queue.dart';
import '../models/category.dart';
import '../models/reminder.dart';

class SupabaseException implements Exception {
  final String message;
  final dynamic error;

  SupabaseException(this.message, [this.error]);

  @override
  String toString() =>
      'SupabaseException: $message${error != null ? '\nError: $error' : ''}';
}

final supabaseProvider =
    riverpod.Provider<SupabaseService>((ref) => SupabaseService());

class SupabaseService {
  final _supabase = Supabase.instance.client;

  User? get currentUser => _supabase.auth.currentUser;

  // Database table operations
  SupabaseQueryBuilder from(String table) => _supabase.from(table);

  // Auth methods
  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    try {
      return await _supabase.auth.signUp(
        email: email,
        password: password,
      );
    } catch (e) {
      throw SupabaseException('Failed to sign up', e);
    }
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw SupabaseException('Failed to sign in', e);
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw SupabaseException('Failed to sign out', e);
    }
  }

  // Task CRUD operations
  Future<List<Task>> getTasks() async {
    try {
      final response = await _supabase
          .from('tasks')
          .select()
          .eq('user_id', _supabase.auth.currentUser?.id)
          .order('created_at', ascending: false);
      return Task.fromJsonList(response);
    } catch (e) {
      throw SupabaseException('Failed to fetch tasks', e);
    }
  }

  Future<Task> createTask(Task task) async {
    try {
      final response =
          await _supabase.from('tasks').insert(task.toJson()).select().single();
      return Task.fromJson(response);
    } catch (e) {
      throw SupabaseException('Failed to create task', e);
    }
  }

  Future<Task> updateTask(Task task) async {
    try {
      final response = await _supabase
          .from('tasks')
          .update(task.toJson())
          .eq('id', task.id)
          .select()
          .single();
      return Task.fromJson(response);
    } catch (e) {
      throw SupabaseException('Failed to update task', e);
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _supabase.from('tasks').delete().eq('id', taskId);
    } catch (e) {
      throw SupabaseException('Failed to delete task', e);
    }
  }

  // Category operations
  Future<List<Category>> getCategories() async {
    try {
      final response = await _supabase
          .from('categories')
          .select()
          .eq('user_id', _supabase.auth.currentUser?.id)
          .order('name');
      return response.map((json) => Category.fromJson(json)).toList();
    } catch (e) {
      throw SupabaseException('Failed to fetch categories', e);
    }
  }

  Future<Category> createCategory(Category category) async {
    try {
      final response = await _supabase
          .from('categories')
          .insert(category.toJson())
          .select()
          .single();
      return Category.fromJson(response);
    } catch (e) {
      throw SupabaseException('Failed to create category', e);
    }
  }

  Future<Category> updateCategory(Category category) async {
    try {
      final response = await _supabase
          .from('categories')
          .update(category.toJson())
          .eq('id', category.id)
          .select()
          .single();
      return Category.fromJson(response);
    } catch (e) {
      throw SupabaseException('Failed to update category', e);
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await _supabase.from('categories').delete().eq('id', categoryId);
    } catch (e) {
      throw SupabaseException('Failed to delete category', e);
    }
  }

  // Reminder operations
  Future<List<Reminder>> getReminders() async {
    try {
      final response = await _supabase
          .from('reminders')
          .select()
          .eq('user_id', _supabase.auth.currentUser?.id)
          .order('scheduled_for');
      return response.map((json) => Reminder.fromJson(json)).toList();
    } catch (e) {
      throw SupabaseException('Failed to fetch reminders', e);
    }
  }

  Future<Reminder> createReminder(Reminder reminder) async {
    try {
      final response = await _supabase
          .from('reminders')
          .insert(reminder.toJson())
          .select()
          .single();
      return Reminder.fromJson(response);
    } catch (e) {
      throw SupabaseException('Failed to create reminder', e);
    }
  }

  Future<void> updateReminderStatus(
      String reminderId, ReminderStatus status) async {
    try {
      await _supabase
          .from('reminders')
          .update({'status': status.toString()}).eq('id', reminderId);
    } catch (e) {
      throw SupabaseException('Failed to update reminder status', e);
    }
  }

  // File storage operations
  Future<String> uploadAttachment(File file, String fileName) async {
    try {
      final response = await _supabase.storage
          .from('attachments')
          .upload('${_supabase.auth.currentUser?.id}/$fileName', file);
      return response;
    } catch (e) {
      throw SupabaseException('Failed to upload attachment', e);
    }
  }

  Future<void> deleteAttachment(String path) async {
    try {
      await _supabase.storage.from('attachments').remove([path]);
    } catch (e) {
      throw SupabaseException('Failed to delete attachment', e);
    }
  }

  // Real-time subscriptions
  Stream<List<Task>> streamTasks() {
    return _supabase
        .from('tasks')
        .stream(primaryKey: ['id'])
        .eq('user_id', _supabase.auth.currentUser?.id)
        .handleError((error) {
          throw SupabaseException('Failed to stream tasks', error);
        })
        .map((response) => Task.fromJsonList(response));
  }

  Stream<List<Category>> streamCategories() {
    return _supabase
        .from('categories')
        .stream(primaryKey: ['id'])
        .eq('user_id', _supabase.auth.currentUser?.id)
        .handleError((error) {
          throw SupabaseException('Failed to stream categories', error);
        })
        .map((response) =>
            response.map((json) => Category.fromJson(json)).toList());
  }

  Stream<List<Reminder>> streamReminders() {
    return _supabase
        .from('reminders')
        .stream(primaryKey: ['id'])
        .eq('user_id', _supabase.auth.currentUser?.id)
        .handleError((error) {
          throw SupabaseException('Failed to stream reminders', error);
        })
        .map((response) =>
            response.map((json) => Reminder.fromJson(json)).toList());
  }
}
