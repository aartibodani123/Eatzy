import React from 'react'
import SignUpForm from './left/SignUpForm'
import RightPanel from './right/RightPanel'
const SignUpPage = () => {
  return (
    <>
    <div className="signup-container">
        <div className="signup-card">
    
            <div className="left-panel">
                <SignUpForm />
            </div>

            <RightPanel />

        </div>
    </div>
    </>
  )
}

export default SignUpPage