import { useState } from 'react';
import { router } from 'expo-router';
import { LinearGradient } from 'expo-linear-gradient';
import { Building2, BriefcaseBusiness, Check, ChevronRight, Eye, EyeOff, GraduationCap, LockKeyhole, Mail, MessageSquareText, ShieldCheck, Sparkles, UsersRound } from 'lucide-react-native';
import { Image, Pressable, SafeAreaView, ScrollView, StyleSheet, Text, TextInput, View } from 'react-native';

type Role = 'Student' | 'Parent' | 'Staff';
type LoginMode = 'password' | 'otp';

const roles = [
  { label: 'Student' as Role, description: 'Learn, track & grow', icon: GraduationCap, color: '#1678d4' },
  { label: 'Parent' as Role, description: 'Stay close to progress', icon: UsersRound, color: '#19a582' },
  { label: 'Staff' as Role, description: 'Lead with confidence', icon: BriefcaseBusiness, color: '#8b54d8' },
];

export default function LoginScreen() {
  const [role, setRole] = useState<Role>('Student');
  const [mode, setMode] = useState<LoginMode>('password');
  const [identifier, setIdentifier] = useState('student@greenvalley.edu');
  const [password, setPassword] = useState('demo123');
  const [otp, setOtp] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState('');

  const signIn = () => {
    if (mode === 'password') {
      if (!identifier.trim() || !password.trim()) {
        setError('Enter your username and password to continue.');
        return;
      }
      if (password !== 'demo123') {
        setError('For this preview, use the demo password: demo123');
        return;
      }
    } else if (otp !== '123456') {
      setError('For this preview, use the verification code: 123456');
      return;
    }
    setError('');
    router.replace('/(tabs)');
  };

  return (
    <LinearGradient colors={['#eef8ff', '#f7fbff', '#ffffff']} style={styles.page}>
      <SafeAreaView style={styles.safe}>
        <ScrollView contentContainerStyle={styles.scroll} showsVerticalScrollIndicator={false}>
          <View style={styles.brandRow}>
            <View style={styles.brandMark}><Building2 size={21} color="#ffffff" strokeWidth={2.4} /></View>
            <View>
              <Text style={styles.brandName}>MYSCHOOL</Text>
              <Text style={styles.brandSub}>SCHOOL ERP</Text>
            </View>
            <View style={styles.securePill}><ShieldCheck size={14} color="#1875d1" /><Text style={styles.secureText}>Secure access</Text></View>
          </View>

          <View style={styles.heroBanner}>
            <Image source={{ uri: 'https://images.pexels.com/photos/8617516/pexels-photo-8617516.jpeg?auto=compress&cs=tinysrgb&h=650&w=940' }} style={styles.heroPhoto} />
            <View style={styles.heroPhotoShade} />
            <View style={styles.heroSun} />
            <View style={styles.heroContent}>
              <View style={styles.heroBadge}><Sparkles size={12} color="#ffffff" /><Text style={styles.heroBadgeText}>SMARTER LEARNING</Text></View>
              <Text style={styles.heroTitle}>Learn today.{`\n`}Lead tomorrow.</Text>
              <Text style={styles.heroSubtitle}>One calm, connected space for every school day.</Text>
            </View>
            <View style={styles.heroWave} />
          </View>

          <View style={styles.loginCard}>
            <View style={styles.welcomeLine}><View style={styles.welcomeAccent} /><View><Text style={styles.cardTitle}>Welcome back</Text><Text style={styles.cardSubtitle}>Sign in to your account to continue.</Text></View></View>

            <View style={styles.roleRow}>
              {roles.map((item) => (
                <Pressable key={item.label} onPress={() => setRole(item.label)} style={[styles.roleButton, role === item.label && styles.roleButtonActive]}>
                  {(() => { const RoleIcon = item.icon; return <RoleIcon size={18} color={role === item.label ? '#ffffff' : item.color} />; })()}
                  <Text style={[styles.roleLabel, role === item.label && styles.roleLabelActive]}>{item.label}</Text>
                </Pressable>
              ))}
            </View>
            <Text style={styles.roleHint}>{roles.find((item) => item.label === role)?.description}</Text>

            <View style={styles.modeRow}>
              <Pressable onPress={() => { setMode('password'); setError(''); }} style={[styles.modeButton, mode === 'password' && styles.modeButtonActive]}>
                <LockKeyhole size={16} color={mode === 'password' ? '#146bc1' : '#7890a8'} />
                <Text style={[styles.modeText, mode === 'password' && styles.modeTextActive]}>Username & password</Text>
              </Pressable>
              <Pressable onPress={() => { setMode('otp'); setError(''); }} style={[styles.modeButton, mode === 'otp' && styles.modeButtonActive]}>
                <MessageSquareText size={16} color={mode === 'otp' ? '#146bc1' : '#7890a8'} />
                <Text style={[styles.modeText, mode === 'otp' && styles.modeTextActive]}>Mobile OTP</Text>
              </Pressable>
            </View>

            {mode === 'password' ? (
              <>
                <Text style={styles.inputLabel}>Username or email</Text>
                <View style={styles.inputWrap}><Mail size={18} color="#88a0b7" /><TextInput value={identifier} onChangeText={setIdentifier} autoCapitalize="none" placeholder="you@school.edu" placeholderTextColor="#9aabba" style={styles.input} /></View>
                <Text style={styles.inputLabel}>Password</Text>
                <View style={styles.inputWrap}><LockKeyhole size={18} color="#88a0b7" /><TextInput value={password} onChangeText={setPassword} secureTextEntry={!showPassword} placeholder="Enter your password" placeholderTextColor="#9aabba" style={styles.input} /><Pressable onPress={() => setShowPassword((visible) => !visible)}>{showPassword ? <EyeOff size={18} color="#7890a8" /> : <Eye size={18} color="#7890a8" />}</Pressable></View>
                <View style={styles.formOptions}><Pressable style={styles.remember}><View style={styles.checkBox}><Check size={11} color="#ffffff" strokeWidth={3} /></View><Text style={styles.rememberText}>Remember me</Text></Pressable><Pressable style={styles.forgot}><Text style={styles.forgotText}>Forgot password?</Text></Pressable></View>
              </>
            ) : (
              <>
                <Text style={styles.inputLabel}>Mobile number</Text>
                <View style={styles.inputWrap}><MessageSquareText size={18} color="#88a0b7" /><TextInput value={identifier} onChangeText={setIdentifier} keyboardType="phone-pad" placeholder="+91 98765 43210" placeholderTextColor="#9aabba" style={styles.input} /></View>
                <Text style={styles.inputLabel}>Verification code</Text>
                <View style={styles.inputWrap}><ShieldCheck size={18} color="#88a0b7" /><TextInput value={otp} onChangeText={setOtp} keyboardType="number-pad" maxLength={6} placeholder="Enter 123456 for preview" placeholderTextColor="#9aabba" style={styles.input} /></View>
              </>
            )}

            {error ? <Text style={styles.error}>{error}</Text> : null}
            <Pressable onPress={signIn} style={({ pressed }) => [styles.signIn, pressed && styles.signInPressed]}><Text style={styles.signInText}>{mode === 'password' ? 'Sign in securely' : 'Verify & continue'}</Text><Text style={styles.arrow}>→</Text></Pressable>
            <Text style={styles.demoNote}>Preview access: {role.toLowerCase()} · password demo123 · OTP 123456</Text>
          </View>

          <View style={styles.footer}><Text style={styles.footerText}>Need help signing in?</Text><Text style={styles.footerLink}> Contact school support</Text></View>
        </ScrollView>
      </SafeAreaView>
    </LinearGradient>
  );
}

const styles = StyleSheet.create({
  page: { flex: 1 }, safe: { flex: 1 }, scroll: { padding: 24, paddingBottom: 32, maxWidth: 620, width: '100%', alignSelf: 'center' },
  brandRow: { flexDirection: 'row', alignItems: 'center', gap: 10, marginBottom: 40 }, brandMark: { width: 40, height: 40, borderRadius: 13, backgroundColor: '#1375d1', alignItems: 'center', justifyContent: 'center' }, brandName: { color: '#1d3853', fontSize: 12, fontWeight: '800', letterSpacing: 1.7 }, brandSub: { color: '#7190ad', fontSize: 9, fontWeight: '700', letterSpacing: 1.5, marginTop: 2 }, securePill: { marginLeft: 'auto', flexDirection: 'row', alignItems: 'center', gap: 5, backgroundColor: '#e5f2ff', paddingHorizontal: 10, paddingVertical: 7, borderRadius: 20 }, secureText: { color: '#1875d1', fontSize: 11, fontWeight: '700' },
  heroBanner: { minHeight: 184, borderRadius: 24, overflow: 'hidden', backgroundColor: '#157bd5', marginBottom: 22, position: 'relative', padding: 22 }, heroPhoto: { position: 'absolute', right: 0, top: 0, bottom: 0, width: '56%', opacity: 0.88 }, heroPhotoShade: { position: 'absolute', right: 0, top: 0, bottom: 0, width: '64%', backgroundColor: '#157bd5', opacity: 0.2 }, heroContent: { zIndex: 2, maxWidth: 245 }, heroBadge: { flexDirection: 'row', alignItems: 'center', gap: 5, marginBottom: 10 }, heroBadgeText: { color: '#d9efff', fontSize: 9, fontWeight: '800', letterSpacing: 1.3 }, heroTitle: { color: '#ffffff', fontSize: 30, lineHeight: 34, fontWeight: '800', letterSpacing: -0.5 }, heroSubtitle: { color: '#d8edff', fontSize: 12, lineHeight: 18, marginTop: 10, maxWidth: 215 }, heroSun: { position: 'absolute', right: 50, top: -26, width: 142, height: 142, borderRadius: 71, backgroundColor: '#62b7ef', opacity: 0.5 }, heroWave: { position: 'absolute', bottom: -38, left: -20, right: -20, height: 72, borderRadius: 45, backgroundColor: '#c4eaff', opacity: 0.65 }, welcomeLine: { flexDirection: 'row', alignItems: 'center', gap: 13 }, welcomeAccent: { width: 4, height: 48, borderRadius: 4, backgroundColor: '#1678d4' }, formOptions: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginTop: 10 }, checkBox: { width: 17, height: 17, borderRadius: 4, backgroundColor: '#1678d4', alignItems: 'center', justifyContent: 'center' }, remember: { flexDirection: 'row', alignItems: 'center', gap: 6 }, rememberText: { color: '#53708e', fontSize: 11, fontWeight: '700' },
  loginCard: { backgroundColor: '#ffffff', borderRadius: 26, padding: 22, shadowColor: '#3c83b7', shadowOpacity: 0.12, shadowRadius: 24, shadowOffset: { width: 0, height: 10 }, elevation: 4 }, cardTitle: { color: '#1b3f60', fontSize: 24, fontWeight: '800' }, cardSubtitle: { color: '#7891a7', fontSize: 13, marginTop: 6, marginBottom: 20 }, roleRow: { flexDirection: 'row', gap: 8 }, roleButton: { flex: 1, minHeight: 46, borderRadius: 13, borderWidth: 1, borderColor: '#dbe7f0', alignItems: 'center', justifyContent: 'center', gap: 4 }, roleButtonActive: { backgroundColor: '#1678d4', borderColor: '#1678d4' }, roleLabel: { color: '#53708e', fontSize: 12, fontWeight: '700' }, roleLabelActive: { color: '#ffffff' }, roleHint: { color: '#8aa0b3', fontSize: 11, marginTop: 8, marginBottom: 20 }, modeRow: { flexDirection: 'row', backgroundColor: '#f3f7fa', borderRadius: 12, padding: 4, marginBottom: 20 }, modeButton: { flex: 1, minHeight: 40, borderRadius: 9, flexDirection: 'row', alignItems: 'center', justifyContent: 'center', gap: 6 }, modeButtonActive: { backgroundColor: '#ffffff', shadowColor: '#aac6da', shadowOpacity: 0.22, shadowRadius: 6, shadowOffset: { width: 0, height: 2 }, elevation: 2 }, modeText: { color: '#7890a8', fontSize: 11, fontWeight: '700' }, modeTextActive: { color: '#146bc1' }, inputLabel: { color: '#3e5c76', fontSize: 12, fontWeight: '700', marginBottom: 7, marginTop: 12 }, inputWrap: { minHeight: 49, borderWidth: 1, borderColor: '#d7e5ee', borderRadius: 12, flexDirection: 'row', alignItems: 'center', paddingHorizontal: 14, gap: 10, backgroundColor: '#fbfdff' }, input: { flex: 1, color: '#294b66', fontSize: 14, minHeight: 47 }, forgot: { alignSelf: 'flex-end', marginTop: 10 }, forgotText: { color: '#1678d4', fontSize: 12, fontWeight: '700' }, error: { color: '#c84e50', fontSize: 12, marginTop: 14, lineHeight: 17 }, signIn: { minHeight: 52, borderRadius: 13, backgroundColor: '#1479d5', flexDirection: 'row', alignItems: 'center', justifyContent: 'center', gap: 12, marginTop: 20, shadowColor: '#1479d5', shadowOpacity: 0.24, shadowRadius: 12, shadowOffset: { width: 0, height: 6 }, elevation: 3 }, signInPressed: { opacity: 0.85, transform: [{ scale: 0.99 }] }, signInText: { color: '#ffffff', fontWeight: '800', fontSize: 14 }, arrow: { color: '#ffffff', fontSize: 20, marginTop: -2 }, demoNote: { textAlign: 'center', color: '#92a6b7', fontSize: 10, marginTop: 14 }, footer: { flexDirection: 'row', justifyContent: 'center', marginTop: 22 }, footerText: { color: '#8299ac', fontSize: 12 }, footerLink: { color: '#1678d4', fontSize: 12, fontWeight: '700' },
});
