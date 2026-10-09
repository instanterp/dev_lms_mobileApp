import { Tabs } from 'expo-router';
import { BarChart3, BookOpen, Home, UserRound } from 'lucide-react-native';

export default function TabLayout() {
  return (
    <Tabs screenOptions={{ headerShown: false, tabBarActiveTintColor: '#1479d5', tabBarInactiveTintColor: '#91a5b5', tabBarStyle: { height: 72, paddingTop: 8, paddingBottom: 10, borderTopColor: '#e5edf3', backgroundColor: '#ffffff' }, tabBarLabelStyle: { fontSize: 10, fontWeight: '700' } }}>
      <Tabs.Screen name="index" options={{ title: 'Home', tabBarIcon: ({ color, size }) => <Home color={color} size={size} /> }} />
      <Tabs.Screen name="academics" options={{ title: 'Academics', tabBarIcon: ({ color, size }) => <BookOpen color={color} size={size} /> }} />
      <Tabs.Screen name="progress" options={{ title: 'Progress', tabBarIcon: ({ color, size }) => <BarChart3 color={color} size={size} /> }} />
      <Tabs.Screen name="profile" options={{ title: 'Profile', tabBarIcon: ({ color, size }) => <UserRound color={color} size={size} /> }} />
    </Tabs>
  );
}
