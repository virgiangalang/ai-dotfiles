---
name: mobile-rn
description: Load when building React Native / Expo mobile apps. Covers project setup, navigation, state management, native APIs, and deployment patterns.
---

# React Native + Expo Patterns

## Project Init

```bash
# Expo (recommended — managed workflow dulu, eject kalau perlu)
npx create-expo-app@latest MyApp --template blank-typescript
cd MyApp
npx expo install expo-router expo-status-bar

# Bare React Native (kalau butuh native modules khusus)
npx react-native@latest init MyApp --template react-native-template-typescript
```

## Folder Structure

```
src/
├── app/              # Expo Router screens (atau screens/ untuk stack nav)
│   ├── (tabs)/
│   │   ├── index.tsx
│   │   └── profile.tsx
│   └── _layout.tsx
├── components/       # Reusable UI
├── hooks/            # Custom hooks
├── lib/              # Utilities, API clients
├── store/            # State management
└── types/            # TypeScript types
```

## Navigation (Expo Router)

```typescript
// app/_layout.tsx
import { Stack } from 'expo-router'

export default function RootLayout() {
  return (
    <Stack>
      <Stack.Screen name="(tabs)" options={{ headerShown: false }} />
      <Stack.Screen name="modal" options={{ presentation: 'modal' }} />
    </Stack>
  )
}

// Navigate
import { router } from 'expo-router'
router.push('/profile')
router.replace('/login')
router.back()
```

## State Management

```typescript
// Zustand (recommended — ringan, TypeScript-friendly)
import { create } from 'zustand'
import { persist, createJSONStorage } from 'zustand/middleware'
import AsyncStorage from '@react-native-async-storage/async-storage'

interface AuthStore {
  user: User | null
  setUser: (user: User | null) => void
}

export const useAuthStore = create<AuthStore>()(
  persist(
    (set) => ({
      user: null,
      setUser: (user) => set({ user })
    }),
    {
      name: 'auth-storage',
      storage: createJSONStorage(() => AsyncStorage)
    }
  )
)
```

## Supabase di React Native

```bash
npx expo install @supabase/supabase-js @react-native-async-storage/async-storage
```

```typescript
import { createClient } from '@supabase/supabase-js'
import AsyncStorage from '@react-native-async-storage/async-storage'

export const supabase = createClient(
  process.env.EXPO_PUBLIC_SUPABASE_URL!,
  process.env.EXPO_PUBLIC_SUPABASE_ANON_KEY!,
  {
    auth: {
      storage: AsyncStorage,
      autoRefreshToken: true,
      persistSession: true,
      detectSessionInUrl: false  // penting untuk RN
    }
  }
)
```

## Env Vars di Expo

```bash
# .env.local
EXPO_PUBLIC_SUPABASE_URL=https://xxx.supabase.co
EXPO_PUBLIC_SUPABASE_ANON_KEY=eyJ...
# Prefix EXPO_PUBLIC_ = exposed ke client (seperti VITE_ di web)
# Tanpa prefix = server only (EAS Build secrets)
```

## Common Native APIs

```typescript
// Kamera
import { CameraView, useCameraPermissions } from 'expo-camera'

// Notifikasi push
import * as Notifications from 'expo-notifications'

// Simpan file
import * as FileSystem from 'expo-file-system'
import * as Sharing from 'expo-sharing'

// Haptics (feedback sentuhan)
import * as Haptics from 'expo-haptics'
Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium)

// Safe area (notch, home indicator)
import { SafeAreaView } from 'react-native-safe-area-context'
```

## Styling

```typescript
// StyleSheet.create untuk performance
import { StyleSheet } from 'react-native'

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#0A0A0A'
  }
})

// NativeWind (Tailwind di RN) — alternatif
import { styled } from 'nativewind'
const StyledView = styled(View)
```

## Platform-Specific Code

```typescript
import { Platform } from 'react-native'

// Inline check
const paddingTop = Platform.OS === 'ios' ? 50 : 30

// File-level split
// Button.ios.tsx   → auto-loaded di iOS
// Button.android.tsx → auto-loaded di Android
```

## Build & Deploy

```bash
# Development build (pakai pada device fisik)
npx expo start --dev-client

# Production build via EAS
npm install -g eas-cli
eas login
eas build:configure
eas build --platform android  # atau ios
eas submit --platform android  # submit ke Play Store
```

## eas.json Boilerplate

```json
{
  "build": {
    "development": {
      "developmentClient": true,
      "distribution": "internal"
    },
    "preview": {
      "distribution": "internal"
    },
    "production": {
      "autoIncrement": true
    }
  }
}
```

## Gotchas

- `useEffect` di RN berjalan di JS thread — jangan block dengan operasi berat
- Image dari URL butuh `{ uri: url }` bukan string langsung
- Flexbox di RN defaultnya `flexDirection: 'column'` (beda dengan web yang `row`)
- Tidak ada `window`, `document`, `localStorage` — gunakan AsyncStorage
- Debug dengan Flipper atau Expo Dev Tools (`npx expo start` lalu tekan `j`)
