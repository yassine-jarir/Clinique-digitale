# Doctor Availability & Booking System

## Overview
This document describes the complete doctor availability and appointment booking system implemented in the application.

## Features Implemented

### 1. **Doctor Availability Display on Rendezvous Page**
- **Location**: `/patient/rendezvous` (when viewing doctors in a specialty)
- **What's Shown**:
  - Which days the doctor is available (Monday-Sunday)
  - Hours for each day (e.g., "09:00 - 17:00")
  - Visual badges for each availability period
  - Empty state when no availability is configured

### 2. **Detailed Booking Page with Time Slots**
- **Location**: `/patient/book-appointment?doctorId={id}`
- **What's Shown**:
  - Doctor's complete weekly availability schedule
  - Date picker (only dates matching availability days)
  - Available time slots for selected date (30-minute intervals)
  - Slot status indicators:
    - ✅ **Available** - Can be booked
    - ❌ **Unavailable** - Already booked, during pause, or insufficient lead time
  - Real-time slot availability based on:
    - Doctor's configured availability
    - Existing appointments
    - Pause/lunch breaks
    - Minimum 2-hour lead time requirement

## Data Flow

### Step 1: Patient Selects Doctor Specialty
```
Patient → Department → Specialty → Doctors List
```

### Step 2: Doctors Display with Availability Preview
- **Backend**: `PatientService.getDoctorsBySpecialty()`
  - Retrieves doctors by specialty
  - Loads availability records for each doctor
  - Maps to `DoctorDTO` with `disponibilites` field
  
- **Frontend**: `rendezvous.jsp`
  - Displays doctor cards
  - Shows availability badges (e.g., "Lu 09:00-17:00")
  - Click "Voir les créneaux disponibles" to proceed

### Step 3: Book Appointment Page
- **Backend**: `PatientBookAppointmentServlet`
  - Loads all doctors for selection
  - If doctorId provided, pre-selects that doctor
  
- **Frontend**: `book-appointment.jsp`
  - **JavaScript API Call**: `/api/doctor-availability?doctorId={id}`
    - Returns weekly schedule grouped by day
    - Displays in organized day cards
    
  - **When Date Selected**: `/api/availabilities?doctorId={id}&date={date}`
    - Returns 30-minute time slots
    - Each slot marked as available/unavailable
    - Patient clicks available slot to select
    
  - **Form Submission**:
    - Validates slot availability server-side
    - Checks for conflicts
    - Creates appointment with PLANNED status

## Key Components

### Backend Services
1. **AvailabilityRepository**
   - `findByDoctorId(UUID)` - All availabilities for a doctor
   - `findByDoctorIdAndDay(UUID, String)` - Availabilities for specific day

2. **SlotService**
   - `generateSlots(UUID doctorId, LocalDate date)` - Generates available time slots
   - Considers: pauses, existing appointments, lead time (2 hours)

3. **PatientService**
   - `getDoctorsBySpecialty(UUID)` - Returns doctors with availability data

### API Endpoints
1. **`/api/doctor-availability`**
   - **Purpose**: Get doctor's weekly schedule
   - **Response**: 
   ```json
   {
     "schedule": [
       {
         "day": "Lundi",
         "periods": [
           {"start": "09:00", "end": "12:00", "status": "AVAILABLE"},
           {"start": "14:00", "end": "17:00", "status": "AVAILABLE"}
         ]
       }
     ]
   }
   ```

2. **`/api/availabilities`**
   - **Purpose**: Get time slots for specific date
   - **Response**:
   ```json
   {
     "slots": [
       {"time": "09:00", "available": true},
       {"time": "09:30", "available": true},
       {"time": "10:00", "available": false}
     ]
   }
   ```

### Frontend Components

#### Rendezvous Page (rendezvous.jsp)
```html
<div class="availability-preview">
  <h4>🗓️ Disponibilité</h4>
  <div class="availability-days">
    <!-- Shows day badges: Lu 09:00-17:00, Ma 09:00-17:00, etc. -->
  </div>
</div>
```

#### Book Appointment Page (book-appointment.jsp)
1. **Doctor's Weekly Schedule Display**
   - Loaded via AJAX from `/api/doctor-availability`
   - Shows which days doctor is available
   
2. **Date Picker**
   - Patient selects a date
   - Minimum date: today
   - Recommended to match available days

3. **Time Slot Selection**
   - Loaded via AJAX from `/api/availabilities`
   - Grid of 30-minute slots
   - Click to select available slot
   - Unavailable slots are grayed out

4. **Appointment Type Selection**
   - CONSULTATION
   - FOLLOW_UP
   - EMERGENCY

## Slot Availability Rules

### A slot is AVAILABLE if:
✅ Doctor has configured availability for that day  
✅ Time is within availability period (not during pause)  
✅ No existing appointment at that time  
✅ At least 2 hours in the future  

### A slot is UNAVAILABLE if:
❌ Outside doctor's availability hours  
❌ During a pause/lunch break  
❌ Already booked by another patient  
❌ Less than 2 hours from now  

## User Experience Flow

1. **Patient browses departments** → Selects department
2. **Patient views specialties** → Selects specialty
3. **Patient sees doctors** with availability preview badges
4. **Patient clicks "Voir les créneaux disponibles"**
5. **System shows doctor's weekly schedule** (which days available)
6. **Patient selects a date** from calendar
7. **System shows available time slots** for that date
8. **Patient selects a time slot** and appointment type
9. **Patient confirms booking**
10. **System validates and creates appointment**

## Technical Implementation

### DTO Enhancement
```java
public class DoctorDTO {
    // ...existing fields...
    private List<AvailabilityDTO> disponibilites; // NEW FIELD
}
```

### Service Enhancement
```java
public List<DoctorDTO> getDoctorsBySpecialty(UUID specialtyId) {
    // Load doctors
    // For each doctor: load availabilities
    // Map to DTOs with availability information
}
```

### Status Indicators
- **AVAILABLE**: Green badge, clickable
- **UNAVAILABLE**: Gray badge, not clickable
- **BOOKED**: Shown as unavailable in slot grid

## Testing

To test the system:

1. **Add Doctor Availability**:
   - Login as doctor
   - Go to availability management
   - Add schedules (e.g., Monday 09:00-17:00)

2. **View as Patient**:
   - Login as patient
   - Navigate: Departments → Specialty → Doctors
   - See availability badges on doctor cards
   - Click "Voir les créneaux disponibles"

3. **Book Appointment**:
   - View weekly schedule
   - Select a date
   - Choose an available slot
   - Complete booking

## Database Schema

### availabilities table
```sql
- id (UUID)
- jour (VARCHAR) - Day name in French
- heure_debut (TIME)
- heure_fin (TIME)
- statut (ENUM: AVAILABLE, UNAVAILABLE, etc.)
- valide (BOOLEAN)
- doctor_id (UUID FK)
```

## Future Enhancements
- Real-time slot updates via WebSocket
- Recurring appointments
- Waitlist for fully booked days
- Email notifications for booking confirmations
- Calendar integration (iCal export)

