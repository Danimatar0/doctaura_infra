// Multi-step Registration Form Handler
(function() {
    'use strict';
    
    let currentStep = 1;
    const totalSteps = 3;

    // Configuration - Update this URL to your API
    const API_BASE_URL = 'https://your-dotnet-api.onrender.com/api/public';

    // Fallback data if API fails
    const fallbackCountries = [
        { id: 1, name: "Lebanon", code: "LB" },
        { id: 2, name: "United States", code: "US" },
        { id: 3, name: "United Kingdom", code: "GB" },
        { id: 4, name: "Canada", code: "CA" },
        { id: 5, name: "Australia", code: "AU" },
        { id: 6, name: "Germany", code: "DE" },
        { id: 7, name: "France", code: "FR" },
        { id: 8, name: "United Arab Emirates", code: "AE" },
        { id: 9, name: "Saudi Arabia", code: "SA" }
    ];
    
    const fallbackSpecialties = [
        { id: 1, name: "General Practice" },
        { id: 2, name: "Internal Medicine" },
        { id: 3, name: "Pediatrics" },
        { id: 4, name: "Cardiology" },
        { id: 5, name: "Dermatology" },
        { id: 6, name: "Orthopedics" },
        { id: 7, name: "Neurology" },
        { id: 8, name: "Psychiatry" },
        { id: 9, name: "Obstetrics & Gynecology" },
        // ... minimal fallback list
    ];

    async function loadCountries() {
        const countrySelect = document.querySelector('select[name="user.attributes.country"]');
        if (!countrySelect) return;

        try {
            // Fetch from your API
            const response = await fetch(`${API_BASE_URL}/countries`, {
                method: 'GET',
                headers: {
                    'Accept': 'application/json'
                }
            });
            
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status} when fetching countries`);
            }
            
            const countries = await response.json();
            
            // Clear existing options except the first "Select Country"
            countrySelect.innerHTML = '<option value="">Select Country</option>';
            
            // Populate dropdown
            countries.forEach(country => {
                const option = document.createElement('option');
                option.value = country.id;   
                option.textContent = country.name;
                countrySelect.appendChild(option);
            });
            
        } catch (error) {
            console.error('Error loading countries:', error);
            
            // Use fallback data
            countrySelect.innerHTML = '<option value="">Select Country</option>';
            fallbackCountries.forEach((country, index) => {
                const option = document.createElement('option');
                option.value = index + 1;         // Temporary ID
                option.textContent = country.name;
                countrySelect.appendChild(option);
            });
        }
    }

    async function loadSpecialties() {
        const specialtySelect = document.getElementById('specialty-select');
        if (!specialtySelect) return;

        try {
            // Fetch from your API
            const response = await fetch(`${API_BASE_URL}/specialties`, {
                method: 'GET',
                headers: {
                    'Accept': 'application/json'
                }
            });
            
             if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status} when fetching specialties`);
            }
            
            const specialties = await response.json();
            
            // Clear existing options except the first "Select Specialty"
            specialtySelect.innerHTML = '<option value="">Select Specialty</option>';
            
            // Populate dropdown
            specialties.forEach(specialty => {
                const option = document.createElement('option');
                option.value = specialty.id;
                option.textContent = specialty.name;
                specialtySelect.appendChild(option);
            });
            
        } catch (error) {
            console.error('Error loading specialties:', error);
            
            // Use fallback data
            specialtySelect.innerHTML = '<option value="">Select Specialty</option>';
            fallbackSpecialties.forEach(specialty => {
                const option = document.createElement('option');
                option.value = index + 1;          // Temporary ID
                option.textContent = specialty.name;
                specialtySelect.appendChild(option);
            });
        }
    }

    function initializeRole() {
        const urlParams = new URLSearchParams(window.location.search);
        const role = urlParams.get('kc_role') || 'patient';

        // console.log('User desired role:', role);
        
        // Update hidden input
        const roleInput = document.getElementById('role-input');
        if (roleInput) {
            roleInput.value = role;
        }

        // Update UI based on role
        if (role === 'doctor') {
            const roleTitle = document.getElementById('role-title');
            const roleDesc = document.getElementById('role-description');
            const iconPatient = document.getElementById('icon-patient');
            const iconPatientCircle = document.getElementById('icon-patient-circle');
            const iconDoctor = document.getElementById('icon-doctor');
            const doctorFields = document.getElementById('doctor-fields');
            const patientFields = document.getElementById('patient-fields');

            if (roleTitle) roleTitle.textContent = 'Register as Doctor';
            if (roleDesc) roleDesc.textContent = 'Create your professional medical account';
            
            if (iconPatient) iconPatient.style.display = 'none';
            if (iconPatientCircle) iconPatientCircle.style.display = 'none';
            if (iconDoctor) iconDoctor.style.display = 'block';
            
            if (doctorFields) doctorFields.style.display = 'block';
            if (patientFields) patientFields.style.display = 'none';
            
            // Make doctor fields required
            const specialtySelect = document.getElementById('specialty-select');
            const doctorInputs = document.querySelectorAll('#doctor-fields input[type="text"]');
            const fileUpload = document.getElementById('medical-cert-upload');
            
            if (specialtySelect) specialtySelect.required = true;
            if (fileUpload) fileUpload.required = true;
            
            doctorInputs.forEach(input => {
                input.required = true;
            });
        }
    }

    // File upload handler
    function initializeFileUpload() {
        const fileInput = document.getElementById('medical-cert-upload');
        const fileError = document.getElementById('file-upload-error');
        const hiddenFileData = document.getElementById('medical-cert-data');
        
        if (fileInput) {
            fileInput.addEventListener('change', function(e) {
                const file = e.target.files[0];
                
                if (!file) return;
                
                // Validate file type
                const allowedTypes = ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'];
                const allowedExtensions = ['.pdf', '.doc', '.docx'];
                const fileExtension = '.' + file.name.split('.').pop().toLowerCase();
                
                if (!allowedTypes.includes(file.type) && !allowedExtensions.includes(fileExtension)) {
                    fileError.textContent = 'Invalid file type. Only PDF, DOC, and DOCX files are allowed.';
                    fileError.style.display = 'block';
                    fileInput.value = '';
                    return;
                }
                
                // Validate file size (5MB max)
                const maxSize = 5 * 1024 * 1024; // 5MB in bytes
                if (file.size > maxSize) {
                    fileError.textContent = 'File size exceeds 5MB. Please upload a smaller file.';
                    fileError.style.display = 'block';
                    fileInput.value = '';
                    return;
                }
                
                // Convert to base64 and store in hidden field
                const reader = new FileReader();
                reader.onload = function(event) {
                    // Store base64 data with filename
                    const base64Data = event.target.result;
                    const fileData = JSON.stringify({
                        filename: file.name,
                        data: base64Data,
                        size: file.size,
                        type: file.type
                    });
                    
                    if (hiddenFileData) {
                        hiddenFileData.value = fileData;
                    }
                    
                    fileError.style.display = 'none';
                    console.log('File uploaded successfully:', file.name);
                };
                
                reader.onerror = function() {
                    fileError.textContent = 'Error reading file. Please try again.';
                    fileError.style.display = 'block';
                };
                
                reader.readAsDataURL(file);
            });
        }
    }

    function showStep(step) {
        const steps = document.querySelectorAll('.form-step');
        steps.forEach(s => s.style.display = 'none');
        
        const currentStepElement = document.querySelector(`.form-step[data-step="${step}"]`);
        if (currentStepElement) {
            currentStepElement.style.display = 'block';
        }
        
        updateProgressIndicator(step);
        updateButtons(step);
    }

    function updateProgressIndicator(step) {
        const indicators = document.querySelectorAll('.step-indicator');
        indicators.forEach((indicator, index) => {
            const stepNum = index + 1;
            const circle = indicator.querySelector('.step-circle');
            
            if (stepNum < step) {
                indicator.classList.add('completed');
                indicator.classList.remove('active');
                circle.style.background = '#10b981';
                circle.style.color = 'white';
            } else if (stepNum === step) {
                indicator.classList.add('active');
                indicator.classList.remove('completed');
                circle.style.background = '#0891b2';
                circle.style.color = 'white';
            } else {
                indicator.classList.remove('active', 'completed');
                circle.style.background = '#e5e7eb';
                circle.style.color = '#9ca3af';
            }
        });
        
        const progressBar = document.getElementById('progress-bar');
        if (progressBar) {
            const progress = ((step - 1) / (totalSteps - 1)) * 100;
            progressBar.style.width = progress + '%';
        }
    }

    function updateButtons(step) {
        const prevBtn = document.getElementById('prevBtn');
        const nextBtn = document.getElementById('nextBtn');
        const submitBtn = document.getElementById('submitBtn');
        
        if (!prevBtn || !nextBtn || !submitBtn) return;
        
        prevBtn.style.display = step === 1 ? 'none' : 'block';
        
        if (step === totalSteps) {
            nextBtn.style.display = 'none';
            submitBtn.style.display = 'block';
        } else {
            nextBtn.style.display = 'block';
            submitBtn.style.display = 'none';
        }
    }

    function validateStep(step) {
        const currentStepElement = document.querySelector(`.form-step[data-step="${step}"]`);
        if (!currentStepElement) return true;
        
        const inputs = currentStepElement.querySelectorAll('input[required], select[required]');
        let isValid = true;
        
        inputs.forEach(input => {
            if (!input.value.trim()) {
                isValid = false;
                input.style.borderColor = '#ef4444';
            } else {
                input.style.borderColor = '#e5e7eb';
            }
        });
        
        if (step === 1) {
            const email = document.getElementById('email');
            const password = document.getElementById('password');
            const passwordConfirm = document.getElementById('password-confirm');
            
            if (email && email.value) {
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email.value)) {
                    email.style.borderColor = '#ef4444';
                    alert('Please enter a valid email address');
                    return false;
                }
            }
            
            if (password && passwordConfirm) {
                if (password.value !== passwordConfirm.value) {
                    passwordConfirm.style.borderColor = '#ef4444';
                    alert('Passwords do not match');
                    return false;
                }
            }
        }

        // Validate doctor fields on step 3
        if (step === 3) {
            const roleInput = document.getElementById('role-input');
            if (roleInput && roleInput.value === 'doctor') {
                const fileInput = document.getElementById('medical-cert-upload');
                if (fileInput && fileInput.required && !fileInput.files.length) {
                    alert('Please upload your medical certification document');
                    fileInput.style.borderColor = '#ef4444';
                    return false;
                }
            }
        }
        
        if (!isValid) {
            alert('Please fill in all required fields');
        }
        
        return isValid;
    }

    function changeStep(direction) {
        if (direction === 1 && !validateStep(currentStep)) {
            return;
        }
        
        const newStep = currentStep + direction;
        
        if (newStep >= 1 && newStep <= totalSteps) {
            currentStep = newStep;
            showStep(currentStep);
        }
    }

    // Expose changeStep globally for onclick handlers
    window.changeStep = changeStep;

    function init() {
        initializeRole();  // Initialize role first
        initializeFileUpload(); // Setup file upload handler
        loadCountries();    // Load countries from API
        loadSpecialties();  // Load specialties from API
        showStep(1);       // Then show first step
    }

    // Initialize
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();