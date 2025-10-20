<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Réserver un Rendez-vous</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .back-link {
            display: inline-block;
            color: white;
            text-decoration: none;
            margin-bottom: 20px;
            font-size: 1.1em;
            transition: all 0.3s;
        }

        .back-link:hover {
            transform: translateX(-5px);
        }

        .header {
            text-align: center;
            color: white;
            margin-bottom: 40px;
        }

        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }

        .doctor-info-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        }

        .doctor-header {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .doctor-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea, #764ba2);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2em;
            font-weight: bold;
        }

        .doctor-details h2 {
            font-size: 1.8em;
            color: #333;
            margin-bottom: 8px;
        }

        .doctor-details p {
            color: #666;
            font-size: 1em;
        }

        /* Step Sections */
        .step-section {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
        }

        .step-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 25px;
            padding-bottom: 20px;
            border-bottom: 3px solid #f0f0f0;
        }

        .step-number {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5em;
            font-weight: bold;
        }

        .step-header h2 {
            font-size: 1.6em;
            color: #333;
        }

        .step-description {
            color: #666;
            margin-bottom: 20px;
            line-height: 1.6;
        }

        /* Day Cards Grid */
        .days-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
        }

        .day-card {
            background: linear-gradient(135deg, #f8f9ff 0%, #fff 100%);
            border: 3px solid #e0e0e0;
            border-radius: 15px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
        }

        .day-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.2);
        }

        .day-card.available {
            border-color: #4caf50;
            background: linear-gradient(135deg, #e8f5e9 0%, #fff 100%);
        }

        .day-card.available:hover {
            border-color: #2e7d32;
            background: #e8f5e9;
        }

        .day-card.selected {
            border-color: #667eea;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        .day-card.past {
            opacity: 0.5;
            cursor: not-allowed;
            background: #f5f5f5;
        }

        .day-card.today {
            border-color: #ff9800;
            border-width: 4px;
        }

        .day-card.no-availability {
            opacity: 0.6;
            cursor: not-allowed;
            background: #fafafa;
        }

        .day-date {
            font-size: 2em;
            font-weight: bold;
            margin-bottom: 8px;
        }

        .day-name {
            font-size: 1.2em;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .day-month {
            font-size: 0.9em;
            opacity: 0.8;
        }

        .day-badge {
            display: inline-block;
            margin-top: 10px;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
        }

        .day-badge.available {
            background: #4caf50;
            color: white;
        }

        .day-badge.today {
            background: #ff9800;
            color: white;
        }

        .day-badge.past {
            background: #9e9e9e;
            color: white;
        }

        /* Time Slots Grid */
        .slots-container {
            margin-top: 20px;
        }

        .slots-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding: 15px;
            background: #f8f9ff;
            border-radius: 10px;
        }

        .slots-info {
            font-size: 1em;
            color: #333;
        }

        .slots-info strong {
            color: #667eea;
            font-size: 1.2em;
        }

        .slots-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
            gap: 15px;
        }

        /* Mobile horizontal scroll for slots */
        @media (max-width: 768px) {
            .slots-grid {
                grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
            }
        }
        .time-slot {
            padding: 20px 15px;
            border: 3px solid #e0e0e0;
            border-radius: 12px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            background: white;
            position: relative;
            font-weight: 600;
            font-size: 1em;
        }

        .time-slot:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        /* Time Display Layout */
        .time-display {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-size: 1.1em;
            font-weight: 600;
            margin-top: 8px;
        }

        .time-start {
            color: inherit;
        }

        .time-separator {
            color: #999;
            font-weight: 400;
            font-size: 1em;
        }

        .time-end {
            color: inherit;
        }

        /* Available - Green */
        .time-slot.available {
            border-color: #4caf50;
            background: linear-gradient(135deg, #e8f5e9 0%, #fff 100%);
            color: #2e7d32;
        }

        .time-slot.available:hover {
            background: #4caf50;
            color: white;
            border-color: #2e7d32;
        }

        /* Selected - Purple */
        .time-slot.selected {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border-color: #667eea;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        /* Booked - Red/Gray */
        .time-slot.booked {
            background: #ffebee;
            border-color: #ef5350;
            color: #c62828;
            cursor: not-allowed;
            opacity: 0.7;
        }

        /* Pause - Orange */
        .time-slot.pause {
            background: #fff3e0;
            border-color: #ff9800;
            color: #e65100;
            cursor: not-allowed;
            opacity: 0.7;
        }

        /* Too Soon - Gray */
        .time-slot.too-soon {
            background: #f5f5f5;
            border-color: #bdbdbd;
            color: #757575;
            cursor: not-allowed;
            opacity: 0.6;
        }

        /* Past - Very Gray */
        .time-slot.past {
            background: #fafafa;
            border-color: #e0e0e0;
            color: #9e9e9e;
            cursor: not-allowed;
            opacity: 0.5;
        }

        .time-slot-icon {
            display: block;
            font-size: 1.5em;
            margin-bottom: 8px;
        }

        /* Tooltip */
        .time-slot[data-tooltip]:hover::after {
            content: attr(data-tooltip);
            position: absolute;
            bottom: 110%;
            left: 50%;
            transform: translateX(-50%);
            padding: 8px 12px;
            background: #333;
            color: white;
            border-radius: 6px;
            font-size: 0.85em;
            white-space: nowrap;
            z-index: 1000;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        }

        .time-slot[data-tooltip]:hover::before {
            content: '';
            position: absolute;
            bottom: 100%;
            left: 50%;
            transform: translateX(-50%);
            border: 6px solid transparent;
            border-top-color: #333;
            z-index: 1000;
        }

        /* Legend */
        .legend {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            margin: 20px 0;
            padding: 20px;
            background: #f8f9ff;
            border-radius: 10px;
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .legend-box {
            width: 30px;
            height: 30px;
            border-radius: 6px;
            border: 2px solid;
        }

        .legend-box.available {
            background: #e8f5e9;
            border-color: #4caf50;
        }

        .legend-box.booked {
            background: #ffebee;
            border-color: #ef5350;
        }

        .legend-box.pause {
            background: #fff3e0;
            border-color: #ff9800;
        }

        .legend-box.too-soon {
            background: #f5f5f5;
            border-color: #bdbdbd;
        }

        /* Form */
        .booking-form {
            margin-top: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: #555;
            margin-bottom: 8px;
        }

        .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1em;
            transition: all 0.3s;
        }

        .form-group select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 18px 40px;
            border: none;
            border-radius: 12px;
            font-size: 1.2em;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        .btn-primary:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
        }

        .loading {
            text-align: center;
            padding: 40px;
            font-size: 1.2em;
            color: #666;
        }

        .loading-spinner {
            display: inline-block;
            width: 50px;
            height: 50px;
            border: 5px solid #f3f3f3;
            border-top: 5px solid #667eea;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-bottom: 15px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .alert.error {
            background: #ffebee;
            color: #c62828;
            border-left: 4px solid #c62828;
        }

        .alert.success {
            background: #e8f5e9;
            color: #2e7d32;
            border-left: 4px solid #2e7d32;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .days-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .slots-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/patient/rendezvous" class="back-link">← Retour</a>

        <div class="header">
            <h1>📅 Réserver un Rendez-vous</h1>
            <p>Sélectionnez un jour puis un créneau horaire</p>
        </div>

        <!-- Doctor Info -->
        <div class="doctor-info-card">
            <div class="doctor-header">
                <div class="doctor-avatar">D</div>
                <div class="doctor-details">
                    <h2 id="doctorName">Chargement...</h2>
                    <p id="doctorSpecialty"></p>
                </div>
            </div>
        </div>

        <!-- Step 1: Select Day -->
        <div class="step-section">
            <div class="step-header">
                <div class="step-number">1</div>
                <h2>Choisissez un jour</h2>
            </div>
            <p class="step-description">
                Sélectionnez un jour parmi les 30 prochains jours. Les jours avec disponibilité sont en vert.
            </p>
            <div id="daysContainer" class="loading">
                <div class="loading-spinner"></div>
                <p>Chargement des jours disponibles...</p>
            </div>
        </div>

        <!-- Step 2: Select Time Slot -->
        <div class="step-section" id="slotsSection" style="display: none;">
            <div class="step-header">
                <div class="step-number">2</div>
                <h2>Choisissez un créneau</h2>
            </div>
            <p class="step-description">
                Sélectionnez un créneau horaire de 30 minutes. Les créneaux verts sont disponibles.
            </p>

            <div class="legend">
                <div class="legend-item">
                    <div class="legend-box available"></div>
                    <span>✓ Disponible</span>
                </div>
                <div class="legend-item">
                    <div class="legend-box booked"></div>
                    <span>✗ Réservé</span>
                </div>
                <div class="legend-item">
                    <div class="legend-box pause"></div>
                    <span>☕ Pause</span>
                </div>
                <div class="legend-item">
                    <div class="legend-box too-soon"></div>
                    <span>⏰ Trop proche</span>
                </div>
            </div>

            <div id="slotsContainer" class="loading">
                <div class="loading-spinner"></div>
                <p>Chargement des créneaux...</p>
            </div>
        </div>

        <!-- Step 3: Confirm Booking -->
        <div class="step-section" id="bookingSection" style="display: none;">
            <div class="step-header">
                <div class="step-number">3</div>
                <h2>Confirmer le rendez-vous</h2>
            </div>

            <div id="alertContainer"></div>

            <form id="bookingForm" method="post">
                <input type="hidden" name="doctorId" id="doctorId" value="${param.doctorId}">
                <input type="hidden" name="date" id="selectedDate">
                <input type="hidden" name="time" id="selectedTime">

                <div class="form-group">
                    <label for="type">Type de consultation *</label>
                    <select name="type" id="type" required>
                        <option value="">-- Sélectionner --</option>
                        <option value="CONSULTATION">Consultation</option>
                        <option value="FOLLOW_UP">Suivi</option>
                        <option value="EMERGENCY">Urgence</option>
                    </select>
                </div>

                <div style="background: #f8f9ff; padding: 20px; border-radius: 10px; margin-bottom: 20px;">
                    <p style="margin-bottom: 10px;"><strong>Récapitulatif :</strong></p>
                    <p>📅 <strong>Date :</strong> <span id="summaryDate">-</span></p>
                    <p>⏰ <strong>Heure :</strong> <span id="summaryTime">-</span></p>
                    <p>🏥 <strong>Médecin :</strong> <span id="summaryDoctor">-</span></p>
                </div>

                <button type="submit" class="btn-primary">✅ Confirmer le rendez-vous</button>
            </form>
        </div>
    </div>

    <script>
        const doctorId = '${param.doctorId}';
        const contextPath = '${pageContext.request.contextPath}';
        let selectedDate = null;
        let selectedTime = null;
        let doctorInfo = null;

        document.addEventListener('DOMContentLoaded', function() {
            console.log('=== PAGE LOADED ===');
            console.log('Doctor ID:', doctorId);
            console.log('Context Path:', contextPath);
            loadDoctorInfo();
            loadDays();
        });

        function loadDoctorInfo() {
            console.log('🔍 Loading doctor info...');
            document.getElementById('doctorName').textContent = 'Dr. ${doctor.nom != null ? doctor.nom : "Docteur"}';
            document.getElementById('doctorSpecialty').textContent = '${doctor.specialite != null ? doctor.specialite : "Médecine générale"}';
        }

        function loadDays() {
            const container = document.getElementById('daysContainer');
            container.innerHTML = '<div class="loading-spinner"></div><p>Chargement des jours...</p>';

            const apiUrl = contextPath + '/api/doctor-days?doctorId=' + doctorId;
            console.log('📡 Fetching days from:', apiUrl);

            fetch(apiUrl)
                .then(response => {
                    console.log('📥 Response status:', response.status);
                    if (!response.ok) {
                        throw new Error('HTTP error! status: ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('📊 Days data received:', data);
                    if (data.error) {
                        throw new Error(data.error);
                    }
                    if (data.days && data.days.length > 0) {
                        console.log('✅ Found', data.days.length, 'days');
                        renderDays(data.days);
                    } else {
                        console.warn('⚠️ No days found in response');
                        container.innerHTML = '<p class="alert error">Aucun jour disponible trouvé pour ce médecin.</p>';
                    }
                })
                .catch(error => {
                    console.error('❌ Error loading days:', error);
                    container.innerHTML = '<p class="alert error">Erreur lors du chargement: ' + error.message + '</p>';
                });
        }

        function renderDays(days) {
            const container = document.getElementById('daysContainer');
            container.innerHTML = '';
            container.className = 'days-grid';

            console.log('🎨 Rendering', days.length, 'day cards');

            days.forEach((day, index) => {
                const card = document.createElement('div');
                card.className = 'day-card';

                const dateParts = day.date.split('-');
                const date = new Date(parseInt(dateParts[0]), parseInt(dateParts[1]) - 1, parseInt(dateParts[2]));

                const dayNum = date.getDate();
                const monthNames = ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin', 'Juil', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc'];
                const month = monthNames[date.getMonth()];
                const year = date.getFullYear();

                if (day.isPast) {
                    card.classList.add('past');
                } else if (day.isToday) {
                    card.classList.add('today');
                }

                if (day.hasAvailability && !day.isPast) {
                    card.classList.add('available');
                    card.onclick = () => selectDay(day, card);
                } else if (!day.isPast) {
                    card.classList.add('no-availability');
                }

                let badge = '';
                if (day.isToday) {
                    badge = '<div class="day-badge today">Aujourd\'hui</div>';
                } else if (day.isPast) {
                    badge = '<div class="day-badge past">Passé</div>';
                } else if (day.hasAvailability) {
                    badge = '<div class="day-badge available">Disponible</div>';
                }

                card.innerHTML =
                    '<div class="day-date">' + dayNum + '</div>' +
                    '<div class="day-name">' + day.dayName + '</div>' +
                    '<div class="day-month">' + month + ' ' + year + '</div>' +
                    badge;

                container.appendChild(card);
            });

            console.log('✅ Rendered all day cards');
        }

        function selectDay(day, cardElement) {
            if (day.isPast || !day.hasAvailability) {
                console.log('⚠️ Cannot select this day:', day.date);
                return;
            }

            console.log('📅 Day selected:', day.date);
            selectedDate = day.date;
            document.getElementById('selectedDate').value = selectedDate;

            document.querySelectorAll('.day-card').forEach(card => card.classList.remove('selected'));
            cardElement.classList.add('selected');

            document.getElementById('slotsSection').style.display = 'block';
            document.getElementById('slotsSection').scrollIntoView({ behavior: 'smooth', block: 'start' });

            loadTimeSlots(day.date);
        }

        function loadTimeSlots(date) {
            const container = document.getElementById('slotsContainer');
            container.className = 'loading';
            container.innerHTML = '<div class="loading-spinner"></div><p>Chargement des créneaux...</p>';

            const apiUrl = contextPath + '/api/enhanced-slots?doctorId=' + doctorId + '&date=' + date;
            console.log('📡 Fetching slots from:', apiUrl);

            fetch(apiUrl)
                .then(response => {
                    console.log('📥 Slots response status:', response.status);
                    if (!response.ok) {
                        throw new Error('HTTP error! status: ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('📊 Slots data received:', data);
                    console.log('   Total slots:', data.totalSlots);
                    console.log('   Available slots:', data.availableCount);

                    if (data.slots && data.slots.length > 0) {
                        renderTimeSlots(data);
                    } else {
                        console.warn('⚠️ No slots found');
                        container.className = '';
                        container.innerHTML = '<p class="alert error">Aucun créneau disponible pour ce jour.</p>';
                    }
                })
                .catch(error => {
                    console.error('❌ Error loading slots:', error);
                    container.className = '';
                    container.innerHTML = '<p class="alert error">Erreur: ' + error.message + '</p>';
                });
        }

        function renderTimeSlots(data) {
            const container = document.getElementById('slotsContainer');
            container.className = 'slots-container';

            console.log('🎨 Rendering', data.slots.length, 'slot cards');

            const header = document.createElement('div');
            header.className = 'slots-header';
            header.innerHTML =
                '<div class="slots-info">' +
                '<strong>' + data.availableCount + '</strong> créneau(x) disponible(s) sur ' + data.totalSlots +
                '</div>';

            const grid = document.createElement('div');
            grid.className = 'slots-grid';

            let renderedCount = 0;
            data.slots.forEach(slot => {
                const slotDiv = document.createElement('div');
                slotDiv.className = 'time-slot ' + slot.status;
                slotDiv.setAttribute('data-tooltip', slot.tooltip);

                // Calculate end time (30 minutes after start)
                const startTime = slot.time.substring(0, 5); // "08:00"
                const endTime = addMinutesToTime(startTime, 30); // "08:30"

                let icon = '';
                if (slot.status === 'available') icon = '✓';
                else if (slot.status === 'booked') icon = '✗';
                else if (slot.status === 'pause') icon = '☕';
                else if (slot.status === 'too-soon') icon = '⏰';
                else if (slot.status === 'past') icon = '🕐';

                slotDiv.innerHTML =
                    '<span class="time-slot-icon">' + icon + '</span>' +
                    '<div class="time-display">' +
                    '<span class="time-start">' + startTime + '</span>' +
                    '<span class="time-separator">|</span>' +
                    '<span class="time-end">' + endTime + '</span>' +
                    '</div>';

                if (slot.available) {
                    slotDiv.onclick = () => selectTimeSlot(slot, slotDiv);
                    renderedCount++;
                }

                grid.appendChild(slotDiv);
            });

            container.innerHTML = '';
            container.appendChild(header);
            container.appendChild(grid);

            console.log('✅ Rendered', renderedCount, 'available slots');
        }

        // Helper function to add minutes to a time string
        function addMinutesToTime(time, minutes) {
            const parts = time.split(':');
            const hours = parseInt(parts[0]);
            const mins = parseInt(parts[1]);
            const totalMins = hours * 60 + mins + minutes;
            const newHours = Math.floor(totalMins / 60);
            const newMins = totalMins % 60;
            return String(newHours).padStart(2, '0') + ':' + String(newMins).padStart(2, '0');
        }

        function selectTimeSlot(slot, slotElement) {
            console.log('⏰ Time slot selected:', slot.time);
            selectedTime = slot.time;
            document.getElementById('selectedTime').value = selectedTime;

            // Update UI
            document.querySelectorAll('.time-slot').forEach(s => s.classList.remove('selected'));
            slotElement.classList.add('selected');

            // Update summary
            const dateParts = selectedDate.split('-');
            const dateObj = new Date(parseInt(dateParts[0]), parseInt(dateParts[1]) - 1, parseInt(dateParts[2]));
            const dateFormatted = dateObj.toLocaleDateString('fr-FR', {
                weekday: 'long',
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });

            document.getElementById('summaryDate').textContent = dateFormatted;
            document.getElementById('summaryTime').textContent = selectedTime;
            document.getElementById('summaryDoctor').textContent = document.getElementById('doctorName').textContent;

            // Show booking section
            document.getElementById('bookingSection').style.display = 'block';
            document.getElementById('bookingSection').scrollIntoView({ behavior: 'smooth', block: 'start' });
        }

        // Form submission
        document.getElementById('bookingForm').addEventListener('submit', function(e) {
            e.preventDefault();

            console.log('📝 Submitting booking form...');
            console.log('   Doctor ID:', doctorId);
            console.log('   Date:', selectedDate);
            console.log('   Time:', selectedTime);
            console.log('   Type:', document.getElementById('type').value);

            const formData = new FormData(this);
            const alertContainer = document.getElementById('alertContainer');

            fetch(contextPath + '/patient/book-appointment', {
                method: 'POST',
                body: formData
            })
            .then(response => {
                console.log('📥 Booking response status:', response.status);
                if (response.redirected) {
                    console.log('✅ Booking successful, redirecting...');
                    window.location.href = response.url;
                } else {
                    return response.text();
                }
            })
            .then(html => {
                if (html && html.includes('error')) {
                    console.error('❌ Booking failed');
                    alertContainer.innerHTML = '<div class="alert error">Erreur lors de la réservation. Veuillez réessayer.</div>';
                }
            })
            .catch(error => {
                console.error('❌ Error submitting booking:', error);
                alertContainer.innerHTML = '<div class="alert error">Erreur: ' + error.message + '</div>';
            });
        });
    </script>
</body>
</html>

