require 'spec_helper'
require_relative '../robot'

describe Robot do
  let(:robot) { Robot.new }
  
  describe '#place' do
    context 'when placing the robot on a valid location' do
      
      it 'sets the position and returns true' do
        expect(robot.place(1, 2, 'NORTH')).to eq [1,2,'NORTH']
        expect(robot.position_info).to eq [1,2,'NORTH']
      end
      
    end
  
    context 'when trying to place the robot on a non-legal square' do
      
      it 'does not place the robot' do
        expect(robot.place(8, 2, 'NORTH')).to be false
      end
    end
    
    context 'when trying to make the robot facing undefined direction' do
      
      it 'does not place the robot' do
        expect(robot.place(1, 2, 'FAKE')).to be false
      end
    end
    
  end
  
  context 'when robot has already been placed' do

    let(:position_info) { [2, 0, 'NORTH'] }
    
    before do
      robot.place(*position_info)
    end
    
    describe '#move' do
      it 'moves the robot one step forward' do
        expect { robot.move }.to change { robot.position_info[1] }.by(1)
      end

      context 'when the robot has a different facing' do
        
        let(:position_info) { [2, 0, 'EAST' ]}

        it 'moves the robot one step in the direction of facing' do
          expect { robot.move }.to change { robot.position_info[0] }.by(1)
        end
      end

      context 'when the robot attempt to move off the edge of the table' do
        
        let(:position_info) { [5, 5,'EAST'] }
        it 'does not move the robot' do
          expect { robot.move }.to_not change { robot.position_info }
        end
      end
    end

    describe '#left' do
      it 'turns the robot to the left' do
        robot.left
        expect(robot.position_info.last).to eq 'WEST'
      end
    end
# 
    describe '#right' do
      it 'turns the robot to the right' do
        robot.right
        expect(robot.position_info.last).to eq 'EAST'
      end
    end
    
    describe '#report' do
      it 'reports the location of the robot' do
        
        expect{ robot.report }.to output(/2,0,NORTH/).to_stdout
      end
    end
 end
end


