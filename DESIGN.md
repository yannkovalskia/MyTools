---
name: Efficient Utility
colors:
  surface: '#f8f9fb'
  surface-dim: '#d9dadc'
  surface-bright: '#f8f9fb'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f3f4f6'
  surface-container: '#edeef0'
  surface-container-high: '#e7e8ea'
  surface-container-highest: '#e1e2e4'
  on-surface: '#191c1e'
  on-surface-variant: '#434655'
  inverse-surface: '#2e3132'
  inverse-on-surface: '#f0f1f3'
  outline: '#737686'
  outline-variant: '#c3c6d7'
  surface-tint: '#0053db'
  primary: '#004ac6'
  on-primary: '#ffffff'
  primary-container: '#2563eb'
  on-primary-container: '#eeefff'
  inverse-primary: '#b4c5ff'
  secondary: '#505f76'
  on-secondary: '#ffffff'
  secondary-container: '#d0e1fb'
  on-secondary-container: '#54647a'
  tertiary: '#943700'
  on-tertiary: '#ffffff'
  tertiary-container: '#bc4800'
  on-tertiary-container: '#ffede6'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#dbe1ff'
  primary-fixed-dim: '#b4c5ff'
  on-primary-fixed: '#00174b'
  on-primary-fixed-variant: '#003ea8'
  secondary-fixed: '#d3e4fe'
  secondary-fixed-dim: '#b7c8e1'
  on-secondary-fixed: '#0b1c30'
  on-secondary-fixed-variant: '#38485d'
  tertiary-fixed: '#ffdbcd'
  tertiary-fixed-dim: '#ffb596'
  on-tertiary-fixed: '#360f00'
  on-tertiary-fixed-variant: '#7d2d00'
  background: '#f8f9fb'
  on-background: '#191c1e'
  surface-variant: '#e1e2e4'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  headline-sm:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
  label-sm:
    fontFamily: Inter
    fontSize: 11px
    fontWeight: '500'
    lineHeight: 14px
  headline-md-mobile:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  base: 4px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  gutter: 16px
  margin-mobile: 16px
  margin-desktop: 32px
---

## Brand & Style
The design system is built on a foundation of **Modern Minimalism** with a focus on high-efficiency utility. It is designed for users who value speed, reliability, and clarity. The aesthetic avoids unnecessary decoration, prioritizing functional density and logical flow. 

The emotional response should be one of "effortless control." By utilizing generous whitespace and a restricted color palette, the UI recedes to the background, allowing the user's data and tools to take center stage. The style is systematic and deterministic, ensuring that every interactive element has a clear purpose and a predictable outcome.

## Colors
This design system utilizes a high-clarity palette focused on "Action Blue" for all primary affordances. 

- **Primary (Action Blue):** Reserved exclusively for interactive elements, primary buttons, and active states.
- **Secondary (Slate):** Used for supporting icons and secondary actions to maintain hierarchy.
- **Surface & Background:** A combination of pure white (#FFFFFF) for cards and containers, and Utility Gray (#F3F4F6) for the base application background to create subtle separation.
- **Status Colors:** Use standard semantic reds and greens only for critical errors or success confirmations, ensuring they do not compete with the primary Action Blue.

## Typography
The typography system uses **Inter** for its exceptional legibility and systematic appearance. 

- **Hierarchy:** Use `display-lg` sparingly for dashboard summaries. `headline-md` serves as the standard page title.
- **Body Text:** `body-md` is the workhorse for all tool descriptions and data inputs.
- **Labels:** Use `label-md` for small headers above input fields or inside tool category chips.
- **Scale:** On mobile devices, avoid sizes above 24px for standard content to maximize vertical density.

## Layout & Spacing
The design system employs a **4px baseline grid** to ensure mathematical consistency across all components.

- **Mobile Layout:** Use a fluid single-column layout with 16px side margins. 
- **Component Padding:** Internal card padding should strictly adhere to `md` (16px) for standard tools and `sm` (8px) for compact utility widgets.
- **Vertical Rhythm:** Group related items using 8px spacing; separate distinct sections using 24px or 32px to create clear visual boundaries without the need for heavy dividers.

## Elevation & Depth
Depth is conveyed through **Tonal Layering** and very soft, ambient shadows. 

- **Level 0 (Background):** Utility Gray (#F3F4F6) acts as the canvas.
- **Level 1 (Cards/Surface):** Pure White (#FFFFFF) surfaces with a 1px border (#E5E7EB). This provides a "flat-plus" look that is cleaner than heavy shadows.
- **Level 2 (Interactive/Floating):** Use a subtle shadow (Y: 2px, Blur: 4px, Opacity: 5% Black) for elements that require user focus, such as active input fields or floating action buttons.
- **Active States:** When a tool card is pressed, remove the shadow and slightly darken the border to provide tactile feedback.

## Shapes
The shape language is **Soft and Professional**. 

- **Buttons & Inputs:** Use a standard 0.25rem (4px) corner radius. This communicates precision and fits the utility-focused nature of the app.
- **Tool Cards:** Use `rounded-lg` (8px) to distinguish large container elements from smaller UI components.
- **Progress Bars:** Use fully rounded (pill-shaped) caps for the track and the fill to provide a friendly, modern contrast to the otherwise geometric layout.

## Components
- **Tool Cards:** White background, 1px border, 8px corner radius. Icons within cards should use the Secondary Slate color, shifting to Action Blue only when the tool is active.
- **Progress Bars:** A 4px or 8px height track using Gray (#E5E7EB) with a fill color of Action Blue (#2563EB). No shadows or gradients on the fill.
- **Input Fields:** 1px border (#E5E7EB), 4px radius. Use `body-md` for input text. The border shifts to 2px Action Blue on focus. Labels should sit 4px above the input field using `label-sm`.
- **Buttons:** 
  - *Primary:* Solid Action Blue with White text.
  - *Secondary:* Ghost style with Action Blue border and text.
- **Chips:** Small, 2px rounded containers with a light gray background (#F3F4F6) for categorizing tools without distracting from the main action.