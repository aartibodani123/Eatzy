<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up | Eatzy — create account</title>
    <!-- Font Awesome (same as login) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* ----- EXACT same base as login page (preserved for consistency) ----- */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;
        }

        body {
            background: linear-gradient(145deg, #fefaf5 0%, #fff6ed 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1.5rem;
            margin: 0;
        }

        /* main card container — two column layout like login */
        .eatzy-signup-wrapper {
            max-width: 1100px;
            width: 100%;
            background: white;
            border-radius: 2.5rem;
            box-shadow: 0 30px 60px -10px rgba(0, 0, 0, 0.15), 0 10px 25px -8px rgba(0, 0, 0, 0.05);
            display: grid;
            grid-template-columns: 1fr 1fr;
            overflow: hidden;
            transition: all 0.2s ease;
        }

        /* LEFT SIDE — sign up form (enriched with your fields & role selection) */
        .auth-panel {
            padding: 2.8rem 2.5rem;
            background: #ffffff;
        }

        /* mini navbar (Home | Menu | About | Contact … ) — exactly as login */
        .mini-nav {
            display: flex;
            gap: 1.8rem;
            align-items: center;
            flex-wrap: wrap;
            margin-bottom: 2.2rem;
            font-size: 0.9rem;
            font-weight: 500;
            color: #4a4a4a;
        }
        .mini-nav a {
            text-decoration: none;
            color: #2e2e2e;
            transition: color 0.2s;
            font-weight: 500;
            letter-spacing: -0.01em;
        }
        .mini-nav a:hover {
            color: #f97316;
        }
        .nav-right {
            margin-left: auto;
            display: flex;
            gap: 1.2rem;
        }
        .nav-right a {
            color: #2e2e2e;
            font-weight: 600;
        }
        .nav-right a:last-child {
            background: #f97316;
            color: white;
            padding: 0.3rem 1rem;
            border-radius: 30px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        /* heading & subtitle */
        .auth-card h2 {
            font-size: 2.1rem;
            font-weight: 700;
            color: #1e1e1e;
            margin-bottom: 0.4rem;
            letter-spacing: -0.02em;
        }
        .subtitle {
            font-size: 1rem;
            color: #6b6b6b;
            margin-bottom: 1.8rem;
            font-weight: 400;
        }

        /* messages (keep your jsp logic compatible) */
        .success-msg, .error-msg {
            padding: 0.8rem 1.2rem;
            border-radius: 60px;
            font-size: 0.9rem;
            margin-bottom: 1.8rem;
            font-weight: 500;
            background: #f0fff4;
            color: #1f7b4d;
            border: 1px solid #b7ebc3;
        }
        .error-msg {
            background: #fff1f0;
            color: #b34033;
            border-color: #ffcdc7;
        }

        /* form elements — consistent with login but adjusted for signup */
        .input-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .input-group {
            margin-bottom: 1rem;
        }
        .input-group input {
            width: 100%;
            padding: 1rem 1.2rem;
            background: #f9f9fb;
            border: 1.5px solid #eaeef2;
            border-radius: 60px;
            font-size: 1rem;
            outline: none;
            transition: all 0.2s;
            color: #1e1e1e;
        }
        .input-group input:focus {
            border-color: #f97316;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(249, 115, 22, 0.12);
        }
        .input-group input::placeholder {
            color: #9ca3af;
            font-weight: 400;
        }

        /* role selection — enhanced version of your original role-card, now modern & matching login style */
        .role-selection {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin: 1.8rem 0 1.5rem;
        }

        .role-card {
            cursor: pointer;
            border: 2px solid #eaeef2;
            border-radius: 24px;
            padding: 1rem 0.8rem 1rem 0.8rem;
            transition: all 0.2s ease;
            background: #f9f9fb;
            display: block;
        }

        .role-card:has(input:checked) {
            border-color: #f97316;
            background: #fff6ed;
            box-shadow: 0 8px 16px -10px #f97316;
        }

        .role-content {
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }
        .role-content .icon {
            font-size: 2rem;
            line-height: 1;
            min-width: 2.2rem;
            text-align: center;
        }
        .role-content h4 {
            font-size: 1rem;
            font-weight: 700;
            color: #1e1e1e;
            margin-bottom: 0.2rem;
        }
        .role-content p {
            font-size: 0.75rem;
            color: #6b6b6b;
            line-height: 1.3;
        }

        /* Hide the radio visually but remain accessible */
        .role-card input[type="radio"] {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }

        .primary-btn {
            background: #f97316;
            color: white;
            border: none;
            border-radius: 60px;
            padding: 1rem 1.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s, transform 0.1s;
            width: 100%;
            margin: 0.8rem 0 1.2rem;
            box-shadow: 0 12px 20px -12px rgba(249, 115, 22, 0.4);
        }
        .primary-btn:hover {
            background: #e85d0e;
        }
        .primary-btn:active {
            transform: scale(0.98);
        }

        .login-text {
            text-align: center;
            color: #4b5563;
            font-size: 0.95rem;
            font-weight: 400;
            border-top: 1px solid #edf2f7;
            padding-top: 1.5rem;
            margin-top: 0.5rem;
        }
        .login-text a {
            color: #f97316;
            font-weight: 600;
            text-decoration: none;
            margin-left: 0.3rem;
            border-bottom: 2px solid transparent;
        }
        .login-text a:hover {
            border-bottom-color: #f97316;
        }

        /* RIGHT SIDE — brand hero / stats (exactly like login) */
        .brand-panel {
            background: #fbf3ea;
            padding: 2.5rem 2rem;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            position: relative;
        }

        .delivery-badge {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            background: rgba(255,255,255,0.6);
            backdrop-filter: blur(6px);
            padding: 1.2rem 1.8rem;
            border-radius: 80px;
            width: fit-content;
            border: 1px solid rgba(255,255,255,0.8);
            box-shadow: 0 6px 14px rgba(0,0,0,0.02);
            margin-bottom: 2.5rem;
        }
        .delivery-badge div:first-child {
            font-weight: 800;
            font-size: 1.8rem;
            color: #2d2d2d;
            line-height: 1.2;
        }
        .delivery-badge div:first-child small {
            font-size: 0.8rem;
            font-weight: 500;
            color: #6b6b6b;
            display: block;
        }
        .stars {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .stars .rating {
            font-weight: 700;
            font-size: 1.4rem;
            color: #1e1e1e;
        }
        .stars .fa-star, .stars .fa-star-half-alt {
            color: #f9b43a;
            font-size: 1rem;
            letter-spacing: 2px;
        }

        .hero-quote {
            margin-top: auto;
            margin-bottom: 2rem;
        }
        .hero-quote h3 {
            font-size: 2.6rem;
            font-weight: 800;
            line-height: 1.2;
            color: #1e1e1e;
            letter-spacing: -0.02em;
        }
        .hero-quote h3 span {
            color: #f97316;
            display: block;
            font-size: 2rem;
            font-weight: 600;
            margin-top: 0.5rem;
        }

        .fast-fresh {
            display: flex;
            gap: 1rem;
            font-weight: 600;
            font-size: 1.1rem;
            color: #3b3b3b;
            margin-top: 2rem;
        }
        .fast-fresh i {
            color: #f97316;
            background: white;
            border-radius: 50%;
            padding: 0.4rem;
            margin-right: 0.2rem;
        }

        .footer-note {
            font-size: 0.8rem;
            color: #8f8f8f;
            margin-top: 1.8rem;
            border-top: 1px dashed #d9d0c7;
            padding-top: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .footer-note p {
            font-weight: 400;
        }

        /* mobile responsiveness */
        @media (max-width: 780px) {
            .eatzy-signup-wrapper {
                grid-template-columns: 1fr;
                border-radius: 2rem;
            }
            .brand-panel {
                display: none;
            }
            .input-row {
                grid-template-columns: 1fr;
                gap: 0;
            }
            .role-selection {
                grid-template-columns: 1fr;
            }
        }

        /* extra touch: keep consistent spacing */
        .auth-card form {
            margin-top: 1.2rem;
        }
    </style>
</head>
<body>
    <div class="eatzy-signup-wrapper">
        <!-- LEFT: signup form (your original fields + role selection + mini nav) -->
        <div class="auth-panel">


            <!-- main signup card -->
            <div class="auth-card">
                <h2>Create Account 🍕</h2>
                <p class="subtitle">Join Eatzy and get your favourite food</p>

                <!-- you can keep JSTL messages if needed -->
                <!--
                <c:if test="${not empty message}">...</c:if>
                <c:if test="${not empty error}">...</c:if>
                -->

                <!-- signup form — method POST, action as in your original -->
                <form action="${pageContext.request.contextPath}/auth/signup" method="post">
                    <!-- first & last name row (side by side) -->
                    <div class="input-row">
                        <div class="input-group">
                            <input type="text" name="firstName" placeholder="First Name" required>
                        </div>
                        <div class="input-group">
                            <input type="text" name="lastName" placeholder="Last Name" required>
                        </div>
                    </div>

                    <!-- email -->
                    <div class="input-group">
                        <input type="email" name="email" placeholder="Email address" required>
                    </div>

                    <!-- password -->
                    <div class="input-group">
                        <input type="password" name="password" placeholder="Password" required>
                    </div>

                    <!-- Role selection: styled exactly as your original but upgraded -->
                    <div class="role-selection">
                        <label class="role-card">
                            <input type="radio" name="role" value="CUSTOMER" checked hidden>
                            <div class="role-content">
                                <div class="icon">👤</div>
                                <div>
                                    <h4>Customer</h4>
                                    <p>Order delicious food easily</p>
                                </div>
                            </div>
                        </label>

                        <label class="role-card">
                            <input type="radio" name="role" value="RESTAURANT_OWNER" hidden>
                            <div class="role-content">
                                <div class="icon">🏪</div>
                                <div>
                                    <h4>Restaurant Owner</h4>
                                    <p>Manage your restaurant & orders</p>
                                </div>
                            </div>
                        </label>
                    </div>

                    <button type="submit" class="primary-btn">Sign Up</button>
                </form>

                <p class="login-text">
                    Already have an account?
                    <a href="${pageContext.request.contextPath}/login-page">Sign in</a>
                </p>
            </div>
        </div>

        <div class="brand-panel">
            <!-- 30 min delivery + rating block -->
            <div class="delivery-badge">
                <div>
                    30 <small>min</small>
                </div>
                <div class="stars">
                    <span class="rating">4.8</span>
                    <div>
                        <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
                    </div>
                </div>
            </div>

            <!-- main hero message -->
            <div class="hero-quote">
                <h3>
                    Fast • Fresh
                    <span>Delivered</span>
                </h3>
            </div>

            <!-- extra flavour -->
            <div class="fast-fresh">
                <span><i class="fas fa-bolt"></i> 30 min or it's free</span>
                <span><i class="fas fa-leaf"></i> 100% fresh</span>
            </div>

            <!-- footer copyright -->
            <div class="footer-note">
                <p>© 2026 <span>Eatzy</span>. Made with ❤️ for food lovers.</p>
                <p><i class="fas fa-bicycle"></i> 10k+ deliveries</p>
            </div>
        </div>
    </div>

    <script>
        (function() {

            const cards = document.querySelectorAll('.role-card');
            cards.forEach(card => {
                card.addEventListener('click', function(e) {
                    const radio = this.querySelector('input[type="radio"]');
                    if (radio) {
                        radio.checked = true;
                    }
                });
            });
        })();
    </script>
</body>
</html>