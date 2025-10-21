<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prendre Rendez-vous</title>
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
            padding: 40px 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        .back-link {
            display: inline-block;
            color: white;
            text-decoration: none;
            margin-bottom: 20px;
            font-size: 1.1em;
        }

        .back-link:hover {
            text-decoration: underline;
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

        .card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            margin-bottom: 30px;
        }

        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert.error {
            background: #fee;
            color: #c33;
            border-left: 4px solid #c33;
        }

        .alert.success {
            background: #efe;
            color: #3c3;
            border-left: 4px solid #3c3;
        }

        .form-section {
            margin-bottom: 30px;
        }

        .form-section h2 {
            font-size: 1.5em;
            color: #333;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: #555;
            margin-bottom: 8px;
        }

        .form-group select,
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1em;
            transition: all 0.3s;
        }

        .form-group select:focus,
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .time-slots {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            gap: 15px;
            margin-top: 15px;
        }

        .time-slot-pair {
            display: flex;
            gap: 8px;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            background: white;
            transition: all 0.3s;
            cursor: pointer;
            align-items: center;
            justify-content: center;
        }

        .time-slot-pair.available:hover {
            border-color: #667eea;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
        }

        .time-slot-pair.selected {
            background: #667eea;
            color: white;
            border-color: #667eea;
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.3);
        }

        .time-slot-pair.unavailable {
            background: #f5f5f5;
            color: #999;
            cursor: not-allowed;
            opacity: 0.5;
        }

        .time-slot {
            padding: 0;
            border: none;
            text-align: center;
            background: transparent;
            font-weight: 600;
            font-size: 1.1em;
            pointer-events: none;
        }

        .time-slot-separator {
            margin: 0 5px;
            font-weight: 600;
            opacity: 0.6;
        }

        .time-slot-pair.selected .time-slot-separator {
            color: white;
        }

        .doctor-card {
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 15px;
        }

        .doctor-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .doctor-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea, #764ba2);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            font-weight: bold;
        }

        .doctor-details h3 {
            font-size: 1.2em;
            color: #333;
            margin-bottom: 5px;
        }

        .doctor-details p {
            color: #666;
            font-size: 0.9em;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 40px;
            border: none;
            border-radius: 10px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            transition: all 0.3s;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }

        .btn-primary:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
        }

        .loading {
            text-align: center;
            padding: 20px;
            color: #666;
        }

        .selected-doctor-info {
            background: #f0f3ff;
            border: 2px solid #667eea;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 25px;
        }

        .selected-doctor-info h3 {
            color: #667eea;
            margin-bottom: 10px;
            font-size: 1.3em;
        }

        .info-badge {
            display: inline-block;
            background: #667eea;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9em;
            margin-right: 10px;
            margin-top: 8px;
        }

        /* Week Navigation Styles */
        .week-navigation {
            margin-bottom: 30px;
        }

        .week-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding: 15px 20px;
            background: #f8f9ff;
            border-radius: 12px;
        }

        .week-title {
            font-size: 1.3em;
            font-weight: 700;
            color: #667eea;
        }

        .week-nav-buttons {
            display: flex;
            gap: 10px;
        }

        .week-nav-btn {
            padding: 10px 20px;
            background: white;
            border: 2px solid #667eea;
            color: #667eea;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .week-nav-btn:hover:not(:disabled) {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }

        .week-nav-btn:disabled {
            opacity: 0.3;
            cursor: not-allowed;
            border-color: #ccc;
            color: #ccc;
        }

        .days-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
            gap: 15px;
            margin-bottom: 25px;
        }

        .day-card {
            background: white;
            border: 3px solid #e0e0e0;
            border-radius: 12px;
            padding: 15px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            position: relative;
        }

        .day-card:hover {
            border-color: #667eea;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.2);
        }

        .day-card.selected {
            border-color: #667eea;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        .day-card.past {
            opacity: 0.4;
            cursor: not-allowed;
            background: #f5f5f5;
        }

        .day-card.past:hover {
            transform: none;
            border-color: #e0e0e0;
        }

        .day-name-short {
            font-size: 0.9em;
            font-weight: 600;
            text-transform: uppercase;
            margin-bottom: 8px;
            color: #999;
        }

        .day-card.selected .day-name-short {
            color: rgba(255, 255, 255, 0.9);
        }

        .day-date {
            font-size: 1.8em;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .day-month-year {
            font-size: 0.85em;
            color: #666;
            margin-bottom: 10px;
        }

        .day-card.selected .day-month-year {
            color: rgba(255, 255, 255, 0.8);
        }

        .slot-count {
            font-size: 0.9em;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            margin-top: 8px;
        }

        .availability-indicator {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            display: inline-block;
        }

        .indicator-available {
            background: #4caf50;
            box-shadow: 0 0 8px rgba(76, 175, 80, 0.6);
        }

        .indicator-unavailable {
            background: #ccc;
        }

        .day-card.selected .slot-count {
            color: rgba(255, 255, 255, 0.95);
            font-weight: 600;
        }

        .selected-day-header {
            background: #f0f3ff;
            border: 2px solid #667eea;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            text-align: center;
        }

        .selected-day-header h3 {
            color: #667eea;
            font-size: 1.4em;
            margin-bottom: 5px;
        }

        .selected-day-header p {
            color: #666;
            font-size: 1em;
        }
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/patient/rendezvous" class="back-link">← Retour à la sélection</a>

    <div class="header">
        <h1>📅 Prendre Rendez-vous</h1>
        <p>Choisissez votre créneau horaire</p>
    </div>
    <div class="card">
        <c:if test="${not empty error}">
            <div class="alert error">
                <span style="font-size: 1.5em;">⚠️</span>
                <span>${error}</span>
            </div>
        </c:if>

        <form method="post" id="appointmentForm">
            <!-- Selected Doctor Info -->
            <c:if test="${not empty selectedDoctorId}">
                <div class="selected-doctor-info">
                    <h3>👨‍⚕️ Médecin sélectionné</h3>
                    <c:forEach var="doctor" items="${doctors}">
                        <c:if test="${doctor.id.toString() == selectedDoctorId}">
                            <div class="doctor-info">
                                <div class="doctor-avatar">${doctor.nom.substring(0,1)}</div>
                                <div class="doctor-details">
                                    <h3>${doctor.titre != null && !doctor.titre.isEmpty() ? doctor.titre : 'Dr'} ${doctor.nom}</h3>
                                    <div>
                                        <span class="info-badge">📧 ${doctor.email}</span>
                                        <c:if test="${not empty doctor.specialite}">
                                            <span class="info-badge">🏥 ${doctor.specialite.nom}</span>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
                <input type="hidden" name="doctorId" id="doctorId" value="${selectedDoctorId}" required>
            </c:if>

            <!-- Select Doctor -->
            <c:if test="${empty selectedDoctorId}">
                <div class="form-section">
                    <h2>👨‍⚕️ Sélectionnez un médecin</h2>
                    <c:forEach var="doctor" items="${doctors}">
                        <div class="doctor-card" data-doctor-id="${doctor.id}" onclick="selectDoctor('${doctor.id}', this)">
                            <div class="doctor-info">
                                <div class="doctor-avatar">${doctor.nom.substring(0,1)}</div>
                                <div class="doctor-details">
                                    <h3>${doctor.titre != null && !doctor.titre.isEmpty() ? doctor.titre : 'Dr'} ${doctor.nom}</h3>
                                    <p>📧 ${doctor.email}</p>
                                    <c:if test="${not empty doctor.specialite}">
                                        <p>🏥 ${doctor.specialite.nom}</p>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <input type="hidden" name="doctorId" id="doctorId" required>
                </div>
            </c:if>

            <!-- Week Navigation Section -->
            <div class="form-section">
                <h2>📆 Choisissez une date</h2>

                <div class="week-navigation">
                    <!-- Week Header with Navigation -->
                    <div class="week-header">
                        <div class="week-title" id="weekTitle">Semaine du ...</div>
                        <div class="week-nav-buttons">
                            <button type="button" class="week-nav-btn" id="prevWeekBtn" onclick="navigateWeek(-1)">
                                ◀ Précédent
                            </button>
                            <button type="button" class="week-nav-btn" id="nextWeekBtn" onclick="navigateWeek(1)">
                                Suivant ▶
                            </button>
                        </div>
                    </div>
                    <!-- Days Grid (7 days) -->
                    <div class="days-grid" id="daysGrid">
                        <!-- Days will be generated by JavaScript -->
                    </div>
                </div>

                <input type="hidden" name="date" id="date" required>
            </div>

            <!-- Select Time -->
            <div class="form-section" id="timeSlotsSection" style="display: none;">
                <div class="selected-day-header" id="selectedDayHeader"></div>

                <h2>⏰ Choisissez une heure</h2>
                <div id="timeSlotsContainer" class="loading">
                    Sélectionnez une date pour voir les créneaux disponibles...
                </div>
                <input type="hidden" name="time" id="time" required>
            </div>

            <!-- Select Type -->
            <div class="form-section">
                <h2>🏥 Type de consultation</h2>
                <div class="form-group">
                    <label for="type">Type *</label>
                    <select name="type" id="type" required>
                        <option value="">-- Sélectionner --</option>
                        <option value="CONSULTATION">Consultation</option>
                        <option value="FOLLOW_UP">Suivi</option>
                        <option value="EMERGENCY">Urgence</option>
                    </select>
                </div>
            </div>

            <button type="submit" class="btn-primary">✅ Confirmer le rendez-vous</button>
        </form>
    </div>
</div>

<script>
    let selectedDoctorId = '${selectedDoctorId}' || null;
    let currentWeekStart = new Date();
    let weekSlotCounts = {};

    function getMonday(date) {
        const d = new Date(date);
        const day = d.getDay();
        const diff = d.getDate() - day + (day === 0 ? -6 : 1);
        return new Date(d.setDate(diff));
    }

    currentWeekStart = getMonday(new Date());

    function selectDoctor(doctorId, element) {
        selectedDoctorId = doctorId;
        document.getElementById('doctorId').value = doctorId;
        document.querySelectorAll('.doctor-card').forEach(card => card.classList.remove('selected'));
        element.classList.add('selected');
        renderWeek();
    }

    function navigateWeek(direction) {
        const doctorId = document.getElementById('doctorId').value;
        if (!doctorId) {
            alert('⚠️ Veuillez d\'abord sélectionner un médecin.');
            return;
        }

        const newDate = new Date(currentWeekStart);
        newDate.setDate(newDate.getDate() + (direction * 7));

        const thisWeekMonday = getMonday(new Date());
        thisWeekMonday.setHours(0, 0, 0, 0);
        newDate.setHours(0, 0, 0, 0);

        if (newDate < thisWeekMonday) {
            return;
        }

        const maxDate = new Date(thisWeekMonday);
        maxDate.setDate(maxDate.getDate() + 28);

        if (newDate >= maxDate) {
            alert('⚠️ Vous ne pouvez réserver que jusqu\'à 4 semaines à l\'avance.\nPour des dates ultérieures, veuillez contacter directement le médecin.');
            return;
        }

        if (direction > 0) {
            const nextBtn = document.getElementById('nextWeekBtn');
            const prevBtn = document.getElementById('prevWeekBtn');
            nextBtn.disabled = true;
            prevBtn.disabled = true;
            nextBtn.innerHTML = '🔍 Vérification...';

            checkWeekAvailability(doctorId, newDate)
                .then(hasSlots => {
                    if (hasSlots) {
                        currentWeekStart = newDate;
                        renderWeek();
                    } else {
                        alert('⚠️ Aucun créneau disponible dans cette semaine.\nVeuillez contacter le médecin pour plus de dates.');
                        updateNavigationButtons();
                    }
                })
                .catch(() => {
                    alert('❌ Erreur lors de la vérification des disponibilités.');
                    updateNavigationButtons();
                });
        } else {
            currentWeekStart = newDate;
            renderWeek();
        }
    }

    function updateNavigationButtons() {
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        const thisWeekMonday = getMonday(today);
        thisWeekMonday.setHours(0, 0, 0, 0);

        const currentWeekTemp = new Date(currentWeekStart);
        currentWeekTemp.setHours(0, 0, 0, 0);

        const prevBtn = document.getElementById('prevWeekBtn');
        prevBtn.disabled = currentWeekTemp.getTime() <= thisWeekMonday.getTime();
        prevBtn.innerHTML = '◀ Précédent';

        const maxDate = new Date(thisWeekMonday);
        maxDate.setDate(maxDate.getDate() + 28);

        const nextWeekStart = new Date(currentWeekStart);
        nextWeekStart.setDate(nextWeekStart.getDate() + 7);

        const nextBtn = document.getElementById('nextWeekBtn');
        nextBtn.disabled = nextWeekStart.getTime() >= maxDate.getTime();
        nextBtn.innerHTML = 'Suivant ▶';
    }

    function checkWeekAvailability(doctorId, weekStart) {
        const days = [];
        for (let i = 0; i < 7; i++) {
            const date = new Date(weekStart);
            date.setDate(date.getDate() + i);
            days.push(date);
        }

        return Promise.all(days.map(date => fetchSlotCount(doctorId, date)))
            .then(slotCounts => {
                return slotCounts.some(count => count > 0);
            });
    }

    function renderWeek() {
        const doctorId = document.getElementById('doctorId').value;
        if (!doctorId) {
            document.getElementById('daysGrid').innerHTML =
                '<p style="text-align: center; color: #999; grid-column: 1/-1; padding: 20px;">Veuillez d\'abord sélectionner un médecin</p>';
            return;
        }

        console.log('🔄 renderWeek called - fetching doctor availability first...');

        const daysGrid = document.getElementById('daysGrid');
        daysGrid.innerHTML = '<div style="grid-column: 1/-1; text-align: center; color: #999;">🔍 Chargement des disponibilités...</div>';

        // CRITICAL FIX: First fetch the doctor's working days from the database
        const apiUrl = '${pageContext.request.contextPath}/api/doctor-availability?doctorId=' + doctorId;

        fetch(apiUrl)
            .then(response => response.json())
            .then(scheduleData => {
                console.log('📊 Doctor schedule received:', scheduleData);

                if (!scheduleData.schedule || scheduleData.schedule.length === 0) {
                    daysGrid.innerHTML = '<p style="text-align: center; color: #999; grid-column: 1/-1; padding: 20px;">❌ Ce médecin n\'a pas de disponibilités configurées</p>';
                    return;
                }

                // Extract the days the doctor actually works (from database)
                const doctorWorkingDays = scheduleData.schedule.map(item => item.day);
                console.log('📅 Doctor works on these days:', doctorWorkingDays);

                // Map French day names to JavaScript day numbers
                const dayNameToNumber = {
                    'Dimanche': 0,
                    'Lundi': 1,
                    'Mardi': 2,
                    'Mercredi': 3,
                    'Jeudi': 4,
                    'Vendredi': 5,
                    'Samedi': 6
                };

                // Find the next occurrence of EACH of the doctor's working days
                const today = new Date();
                today.setHours(0, 0, 0, 0);

                const daysToCheck = [];
                const daysAlreadyAdded = new Set();

                // Look ahead up to 14 days to find next occurrence of each working day
                for (let i = 0; i < 14 && daysAlreadyAdded.size < doctorWorkingDays.length; i++) {
                    const date = new Date(today);
                    date.setDate(date.getDate() + i);
                    const jsDay = date.getDay();

                    // Find which French day name this corresponds to
                    let frenchDayName = null;
                    for (const [name, num] of Object.entries(dayNameToNumber)) {
                        if (num === jsDay) {
                            frenchDayName = name;
                            break;
                        }
                    }

                    // Check if doctor works on this day AND we haven't added it yet
                    if (frenchDayName && doctorWorkingDays.includes(frenchDayName) && !daysAlreadyAdded.has(frenchDayName)) {
                        daysToCheck.push(date);
                        daysAlreadyAdded.add(frenchDayName);
                        console.log('  ✅ Will check:', date.toLocaleDateString('fr-FR'), '(', frenchDayName, ')');
                    }
                }

                console.log('📅 Checking', daysToCheck.length, 'days (doctor works', doctorWorkingDays.length, 'days per week)');

                // Update title
                document.getElementById('weekTitle').textContent = 'Jours disponibles (prochaines dates)';

                // Hide navigation buttons
                document.getElementById('prevWeekBtn').style.display = 'none';
                document.getElementById('nextWeekBtn').style.display = 'none';

                // Now fetch slot counts for each of these days
                Promise.all(daysToCheck.map(date => fetchSlotCount(doctorId, date)))
                    .then(slotCounts => {
                        daysGrid.innerHTML = '';

                        daysToCheck.forEach((date, index) => {
                            const dayCard = createDayCard(date, slotCounts[index]);
                            if (dayCard) {
                                daysGrid.appendChild(dayCard);
                            }
                        });

                        // Check if no days were added
                        if (daysGrid.children.length === 0) {
                            daysGrid.innerHTML = '<p style="text-align: center; color: #999; grid-column: 1/-1; padding: 20px;">❌ Aucun créneau disponible</p>';
                        } else {
                            console.log('✅ Showing', daysGrid.children.length, 'days with availability');
                        }
                    })
                    .catch(error => {
                        console.error('Error loading slot counts:', error);
                        daysGrid.innerHTML = '<p style="text-align: center; color: #c33; grid-column: 1/-1;">❌ Erreur de chargement des créneaux</p>';
                    });
            })
            .catch(error => {
                console.error('Error loading doctor schedule:', error);
            });
    }

    function fetchSlotCount(doctorId, date) {
        const dateStr = formatDate(date);
        const apiUrl = '${pageContext.request.contextPath}/api/availabilities?doctorId=' + doctorId + '&date=' + dateStr;

        console.log('📡 Fetching slots for:', dateStr, date.toLocaleDateString('fr-FR', {weekday: 'long'}));

        return fetch(apiUrl)
            .then(response => response.json())
            .then(data => {
                console.log('📊 Response for', dateStr, ':', data);
                // Only count slots if there are availability periods defined AND available slots exist
                if (data.slots && data.slots.length > 0) {
                    const availableCount = data.slots.filter(s => s.available).length;
                    console.log('  ✅ Available slots:', availableCount, '/ Total:', data.slots.length);
                    return availableCount;
                }
                console.log('  ❌ No slots returned for this day');
                return 0;
            })
            .catch(error => {
                console.error('  ⚠️ Error fetching slots:', error);
                return 0;
            });
    }

    function createDayCard(date, slotCount) {
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        const isPast = date < today;

        const dayName = date.toLocaleDateString('fr-FR', {weekday: 'long'});

        console.log('🎨 Creating card for', date.toLocaleDateString('fr-FR'), dayName, '| Slots:', slotCount, '| Past:', isPast);

        // Don't show days with no available slots OR past days
        if (slotCount === 0 || isPast) {
            console.log('  ⏭️ SKIPPING - no slots or past date');
            return null;
        }

        console.log('  ✅ SHOWING day card');
        const dayCard = document.createElement('div');
        dayCard.className = 'day-card';

        const dayNames = ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'];
        const monthNames = ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin', 'Juil', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc'];

        const dayNameShort = dayNames[date.getDay()];
        const dayDate = date.getDate();
        const monthYear = monthNames[date.getMonth()] + " " + date.getFullYear();

        const indicatorClass = 'indicator-available';
        const slotText = slotCount + " slot" + (slotCount > 1 ? "s" : "");

        dayCard.innerHTML =
            "<div class=\"day-name-short\">" + dayNameShort + "</div>" +
            "<div class=\"day-date\">" + dayDate + "</div>" +
            "<div class=\"day-month-year\">" + monthYear + "</div>" +
            "<div class=\"slot-count\">" +
            "<span class=\"availability-indicator " + indicatorClass + "\"></span>" +
            "<span>" + slotText + "</span>" +
            "</div>";

        dayCard.onclick = () => selectDay(date, dayCard, slotCount);

        return dayCard;
    }

    function selectDay(date, cardElement, slotCount) {
        document.querySelectorAll('.day-card').forEach(function(card) {
            card.classList.remove('selected');
        });
        cardElement.classList.add('selected');
        var dateStr = formatDate(date);
        document.getElementById('date').value = dateStr;
        var dayNames = ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'];
        var monthNames = ['janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'];
        var fullDayName = dayNames[date.getDay()];
        var fullDate = date.getDate() + ' ' + monthNames[date.getMonth()] + ' ' + date.getFullYear();
        var creneauText = slotCount + ' créneau' + (slotCount > 1 ? 'x' : '') + ' disponible' + (slotCount > 1 ? 's' : '');
        document.getElementById('selectedDayHeader').innerHTML =
            '<h3>📅 ' + fullDayName + ' ' + fullDate + '</h3>' +
            '<p>' + creneauText + '</p>';
        loadTimeSlots();
    }
    function formatDate(date) {
        var year = date.getFullYear();
        var month = String(date.getMonth() + 1);
        var day = String(date.getDate());
        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;
        return year + '-' + month + '-' + day;
    }

    const container = document.getElementById('timeSlotsContainer');
    const section = document.getElementById('timeSlotsSection');

    function loadTimeSlots() {
        const doctorId = document.getElementById('doctorId').value;
        const date = document.getElementById('date').value;

        if (!doctorId || !date) return;

        section.style.display = 'block';
        container.innerHTML = '🔍 Chargement...';

        const apiUrl = '${pageContext.request.contextPath}/api/availabilities?doctorId=' + doctorId + '&date=' + date;

        fetch(apiUrl)
            .then(response => response.json())
            .then(data => {
                if (data.slots && data.slots.length > 0) {
                    const availableSlots = data.slots.filter(s => s.available);

                    if (availableSlots.length === 0) {
                        container.innerHTML = '<p style="text-align: center; color: #999; padding: 20px;">❌ Aucun créneau disponible.</p>';
                    } else {
                        container.innerHTML = '<div class="time-slots"></div>';
                        const slotsDiv = container.querySelector('.time-slots');

                        for (var i = 0; i < data.slots.length; i += 2) {
                            var slot1 = data.slots[i];
                            var slot2 = data.slots[i + 1];

                            var isAvailable = slot1.available && slot2 && slot2.available;

                            if (!isAvailable) continue;

                            var pairDiv = document.createElement('div');
                            pairDiv.className = 'time-slot-pair available';

                            var time1 = slot1.time.length > 5 ? slot1.time.substring(0, 5) : slot1.time;
                            var time2 = slot2 ? (slot2.time.length > 5 ? slot2.time.substring(0, 5) : slot2.time) : '';

                            var startTime = slot1.time;

                            pairDiv.innerHTML =
                                '<span class="time-slot">' + time1 + '</span>' +
                                '<span class="time-slot-separator">→</span>' +
                                '<span class="time-slot">' + time2 + '</span>';

                            pairDiv.title = 'Créneau de 1 heure';

                            pairDiv.onclick = (function(time, element) {
                                return function() { selectTimeSlot(time, element); };
                            })(startTime, pairDiv);

                            slotsDiv.appendChild(pairDiv);
                        }

                        if (slotsDiv.children.length === 0) {
                            container.innerHTML = '<p style="text-align: center; color: #999; padding: 20px;">❌ Aucun créneau disponible.</p>';
                        }
                    }
                } else {
                    container.innerHTML = '<p style="text-align: center; color: #999;">⚠️ Aucune disponibilité.</p>';
                }
            })
            .catch(error => {
                console.error('Error:', error);
                container.innerHTML = '<p style="text-align: center; color: #c33;">❌ Erreur</p>';
            });
    }

    function selectTimeSlot(time, element) {
        document.getElementById('time').value = time;
        document.querySelectorAll('.time-slot-pair').forEach(pair => pair.classList.remove('selected'));
        element.classList.add('selected');
    }

    // Initialize on page load
    document.addEventListener('DOMContentLoaded', function() {
        <c:if test="${not empty selectedDoctorId}">
        selectedDoctorId = '${selectedDoctorId}';
        if (selectedDoctorId) {
            document.getElementById('doctorId').value = selectedDoctorId;
            renderWeek();
        }
        </c:if>
    });

    // Form validation
    document.getElementById('appointmentForm').addEventListener('submit', function(e) {
        const time = document.getElementById('time').value;
        if (!time) {
            e.preventDefault();
            alert('⚠️ Veuillez sélectionner un créneau horaire.');
        }
    });
</script>
</body>
</html>
